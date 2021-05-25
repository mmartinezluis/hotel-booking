

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