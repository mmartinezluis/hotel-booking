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

NAVABAR
    <header>
    <nav class="nav" id="navbar">
      <% if !!session[:user_id] %>
        <ul class="nav-list">
          <li><%= link_to "Hotel Search", hotel_search_path %></li>
          <li><%= link_to "Hotels" %></li>
          <li><%= link_to "Reservations", reservations_path %></li>
          <li><%= link_to "Cities", cities_path %></li>
          <li><%= link_to "Reviews", reviews_path %></li>
          <li><%= link_to "Trending", hotels_path %></li>
          <li><%= link_to "Logout", logout_path %></li>
        </ul>
      <% else %>
        <ul class="nav-list">
          <li><%= link_to "Log In", "/singin" %></li>
          <li><%= link_to "Sign Up", new_user_path %></li>
        </ul>
      <% end %>
    </nav>
    </header>