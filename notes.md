user model
has_many reservations
has_mnay hotels:: through reservations
_________________________


hotel model
has_many reservations
_________________________


city model
has_many hotels
_________________________


reservation model
user_id
hotelid
_________________________


Add most popular hotels, 
users with most reserations,


Navigation bar: Dashboard | Hotel Search | Hotels | Rservations | Cities | Reviews | Trending



    <% @reservations.each do |reservation| %>
      <div>
        <h2><%= link_to reservation.hotel.name, reservation_path(reservation) %></h2>
        <p><%= reservation.hotel.city.code %></p>
        <%= render 'reservations/info', :reservation => reservation %>
      </div>
    <% end %>