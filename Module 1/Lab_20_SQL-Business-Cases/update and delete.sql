use lab_mysql;
update Salespersons 
set store = "Miami" 
where name = "Paige Turner";

alter table Customers
add new_email varchar(255);
update Customers
set new_email = "ppicasso@gmail.com"
where name = "Pablo Picasso";
update Customers
set new_email = "lincoln@us.gov"
where name = "Abraham Lincoln";
update Customers
set new_email = "hello@napoleon.me"
where name = "Napoléon Bonaparte";

Delete from Cars WHERE ID = 11;