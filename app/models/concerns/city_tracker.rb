module CityTracker
    
    def self.cities_list_cache_key
        "app/cities_list"
    end

    def self.retrieve_cities
        cities = Rails.cache.redis.with { |c| c.get(CityTracker.cities_list_cache_key) }
        cities ||= Rails.cache.redis.with { |c| c.setex(CityTracker.cities_list_cache_key, 3600*60, City.pluck(:name, :code).to_json) }
        cities
    end
end