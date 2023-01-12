# Module to be used for caching purposes
module HotelTracker
    @@most_popular_ids = []

    # Maintains user hotels sorted by reservations checkin date descending
    class ForUser
        attr_accessor :hotel_ids, :upcoming_reservations_counter
        def initialize(reservations = [])
            raise TypeError, "If supplied, the argument must be an array" if reservations && !reservations.length
            info = HotelTracker::ReservationsPriorityQueue.new(reservations)
            @hotel_ids = info.values
            # byebug
            @upcoming_reservations_counter = info.upcoming
        end
    end

    # Keeps track of the top 3 hotels with most reservations
    class ForApp
    end

    private
    class ReservationsPriorityQueue
        attr_accessor :map, :values, :upcoming

        def initialize(reservations)            
            @map = {}
            @values = []
            @upcoming = 0
            self.build_queue(reservations) if reservations.length > 0
        end

        def build_queue(reservations)
            # reservations should be sorted already by checkin date descending 
            today = Date.today.to_s
            reservations.each do |re|
                prev_re = map[re.hotel_id]    
                map[re.hotel_id] = re if !prev_re
                @upcoming += 1 if re.checkin_date >= today
            end
            @values = map.keys
        end

        # for later, write method and data structures to add a reservation and keep hotel ids
        # sorted by reservation checkin date descending
        # Potential solution: use a heap and a hashmap; the heap will store the hotel ids;
        # the hash map will store the hotel id as key and the hotel index from heap as value
        def add(value)
        end
    end


end