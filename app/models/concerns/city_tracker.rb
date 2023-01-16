module CityTracker

    def self.cities_list_cache_key(user)
        "cities_list/#{user.cache_key}"
    end

    def self.retrieve_cities_list(user)
        city_ids = Rails.cache.redis.with { |c| c.zrevrange(CityTracker.cities_list_cache_key(user), 0, -1) }
        city_ids = self.build_cities_list(user) if city_ids.empty?
        city_ids
    end
    
    def self.build_cities_list(user)
        user_cities_key = CityTracker.cities_list_cache_key(user)
        reservations = user.reservations.presence
        return [] if !reservations
        reservations.includes(hotel: [:city]).each do |re|
            re_time = re.checkin_date.to_time.to_i
            Rails.cache.redis.with { |c| c.zadd(user_cities_key, re_time, re.hotel.city_id, gt: true) }
        end
        Rails.cache.redis.with { |c| c.expire(user_cities_key, 3600) }
        Rails.cache.redis.with { |c| c.zrevrange(user_cities_key, 0, -1) }
    end

    def self.city_codes_cache_key
        "app/city_codes"
    end

    def self.retrieve_city_codes
        cache_key = CityTracker.city_codes_cache_key
        cities = Rails.cache.redis.with { |c| c.get(cache_key) }
        cities ||= Rails.cache.redis.with { |c| c.setex(cache_key, 3600*60, City.pluck(:name, :code).to_json) }
    end

end