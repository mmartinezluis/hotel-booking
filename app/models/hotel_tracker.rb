# Module to be used for caching purposes
module HotelTracker
    @@most_popular_ids = []

    # Maintains user hotels sorted by reservations checkin date descending
    class ForUser
        attr_accessor 
        def initialize()
        end
    end

    # Keeps track of the top 3 hotels with most reservations
    class ForApp
    end

    class ReservationsPriorityQueue
        attr_accessor :reservation_ids, :list, :queue

        def initialize(reservations = [])
            return if reservations.class != Array
            @reservation_ids = reservations.length > 0 ? self.build_queue(reservations) : []
            @list = {}
        end

        def build_queue(reservations)
            reservations.each do |re|
                # if list[re.hotel_id]
            end

        end

        def add(value)
        end

    end
end