# Module to be used for caching purposes
module HotelTracker
    @@most_popular_ids = []

    # Maintains user hotels sorted by reservations checkin date descending
    class ForUser
        attr_accessor :hotel_ids, :upcoming_reservations_counter
        def initialize(user, reservations = [])
            raise TypeError, "If supplied, the argument must be an array" if reservations && !reservations.length
            info = HotelTracker::HotelsSortedSet.new(user, reservations)
            @hotel_ids = info.values
            @upcoming_reservations_counter = info.upcoming
        end
    end

    # Keeps track of the top 3 hotels with most reservations
    class ForApp

        # This should be a batch operation, and asynchronous
        # This operation can be very tricky, as reservations
        # could be happening while the method is running;
        # need to apply "eventual consistency"
        def build_most_popular(hotels)
            most_popular_key = HotelTracker.most_popular_cache_key
            current_score = Rails.cache.redis.with { |c| c.zscore(HotelTracker.most_popular_cache_key, hotel_id)}
            hotels.each do |hotel|
              Rails.cache.redis.with { |c| c.zadd(HotelTracker.most_popular_cache_key, hotel.reservations.length, hotel.id)}
            end
        end

        def increase_most_popular(hotel_id)
            current_score = Rails.cache.redis.with { |c| c.zscore(HotelTracker.most_popular_cache_key, hotel_id)}
            Rails.cache.redis.with do |c| 
                c.zscore(HotelTracker.most_popular_cache_key, current_score ? current_score +=1 : 1, hotel_id)
            end
        end
    end

    private
    class HotelsSortedSet
        attr_accessor :map, :values, :upcoming

        def initialize(reservations)            
            @map = {}
            @values = []
            @upcoming = 0
            self.build_queue(reservations) if reservations.length > 0
        end

        # reservations should be sorted already by checkin date descending 
        def build_sorted_set(user, reservations)
            user_hotels_key = HotelTracker.hotels_lists_cache_key(user)
            rev_counter_key = HotelTracker.upcoming_re_counter_cache_key(user)

            Rails.cache.redis.with do |conn|
                # Clean up the hotels sorted set and upcoming reservations counter caches
                conn.del user_hotels_key
                conn.set(rev_counter_key, 0)

                today = Date.today.to_time.to_i

                reservations.each do |re|
                    prev_re = map[re.hotel_id]    
                    re_time = re.checkin_date.to_time.to_i
                    if !prev_re do
                        map[re.hotel_id] = re
                        conn.zadd(user_hotels_key, re.checkin_date.to_time.to_i, re.hotel_id.to_s)
                    end
                    conn.incr(rev_counter_key) if re_time >= today
                end
                @values = map.keys
            end
            @values = Rails.cache.redis.with { |c| c.zrange(user_hotels_key, 0, -1)}
            @upcoming = Rails.cache.redis.with { |c| c.get(rev_counter_key)}
        end
    end

    def self.hotels_list_cache_key(user)
    "hotels_list/#{user.cache_key}"
    end

    def self.upcoming_re_counter_cache_key(user)
    "upcoming_re_counter/#{user.cache_key}"
    end

    def self.most_popular_cache_key
    "most_popular_hotels"
    end
end