# Module to be used for caching purposes
module HotelTracker
    @@most_popular_ids = []

    class ReservationsPriorityQueue
        attr_accessor :map, :values

        def initialize(reservations = [])
            return if reservations.class != Array
            @map = {}
            @values = []
            self.build_queue(reservations) if reservations.length > 0
        end

        def build_queue(reservations)
            # reservations should be sorted already by checkin date descending 
            reservations.each do |re|
                prev_re = map[re.hotel_id]    
                map[re.hotel_id] = re if !prev_re
            end
            map.keys
        end

        # for later, write method and data structures to add a reservation and keep hotel ids
        # sorted by reservation checkin date descending
        # Potential solution: use a heap and a hashmap; the heap will store the hotel ids;
        # the hash map will store the hotel id as key and the hotel index from heap as value
        def add(value)
        end
    end

    # Maintains user hotels sorted by reservations checkin date descending
    class ForUser
        attr_accessor :hotel_ids
        def initialize(reservations)
            @hotel_ids = HotelTracker::ReservationsPriorityQueue.new(reservations)
        end
    end

    # Keeps track of the top 3 hotels with most reservations
    class ForApp
    end


end