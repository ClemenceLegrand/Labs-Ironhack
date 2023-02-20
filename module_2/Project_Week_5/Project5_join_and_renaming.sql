CREATE SCHEMA IF NOT EXISTS airbnb_paris;
USE airbnb_paris;
SELECT ab.address as Address, 
location/lat as Latitude, 
location/lng as Longitude,
name as Name,
numberOfGuests as Number_of_Guests,
pricing/rate/amount as Price_per_Night,
roomType as Acc_Type,
room_type.Accommodation_Type as Room_Type,
ab.stars as Stars,
ad.Final_Arrondissement as Arrondissement,
url as Url
FROM 
airbnb_paris_clean ab
INNER JOIN address ad ON ad.Name=ab.name
INNER JOIN room_type rt ON rt.Name=ad.Name;