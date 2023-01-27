
SELECT count(*) FROM person;
SELECT * FROM crime_scene_report WHERE date="20180115" AND type="murder" AND city="SQL City"
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".
SELECT * FROM person WHERE address_street_name="Northwestern Dr" ORDER BY address_number DESC LIMIT 1;
-- id 14887 
SELECT * FROM person WHERE address_street_name="Franklin Ave" AND name LIKE "%Annabel%";
-- id 16371
SELECT * FROM interview WHERE person_id=14887 OR ;
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
-- The membership number on the bag started with "48Z". Only gold members have those bags. 
-- The man got into a car with a plate that included "H42W".
-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
SELECT * FROM get_fit_now_member WHERE id LIKE "48Z%" AND membership_status = "gold";
-- id 28819 67318
SELECT * FROM person p JOIN drivers_license d ON p.license_id=d.id WHERE p.id="28819" OR p.id="67318";
-- id	name	67318	Jeremy Bowers





