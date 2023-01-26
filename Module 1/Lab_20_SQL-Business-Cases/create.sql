CREATE DATABASE lab_mysql;
USE lab_mysql;
CREATE TABLE Cars (
VIN int NOT NULL UNIQUE,
Manufacturer varchar(255),
Model varchar(255) NOT NULL,
Year int, 
Color varchar(255));
DELETE Cars FROM lab_mysql;
DROP TABLE Cars;
CREATE TABLE IF NOT EXISTS Cars (
VIN int NOT NULL UNIQUE AUTO_INCREMENT,
Manufacturer varchar(255),
Model varchar(255) NOT NULL,
Year int, 
Color varchar(255));
CREATE TABLE Customers (
Customer_id int NOT NULL UNIQUE auto_increment,
Name varchar(255) NOT NULL,
Phone int,
Email varchar(255) NOT NULL,
Adress varchar(255),
City varchar(255) NOT NULL,
Country varchar(255) NOT NULL,
Province varchar(255),
ZIP int NOT NULL);
DROP TABLE Cars;
DROP TABLE Customers;
CREATE TABLE IF NOT EXISTS Cars (
ID int NOT NULL UNIQUE auto_increment,
VIN int NOT NULL UNIQUE,
Manufacturer varchar(255),
Model varchar(255) NOT NULL,
Year int, 
Color varchar(255));
CREATE TABLE IF NOT EXISTS Customers (
ID int NOT NULL UNIQUE auto_increment,
Customer_id int NOT NULL UNIQUE,
Name varchar(255) NOT NULL,
Phone int,
Email varchar(255) NOT NULL,
Adress varchar(255),
City varchar(255) NOT NULL,
Country varchar(255) NOT NULL,
Province varchar(255),
ZIP int NOT NULL);
CREATE TABLE IF NOT EXISTS Salespersons (
ID int NOT NULL UNIQUE auto_increment,
Staff_id varchar(255) NOT NULL UNIQUE,
Name varchar(255) NOT NULL,
Store varchar(255) NOT NULL);
CREATE TABLE Invoices (
ID int NOT NULL UNIQUE auto_increment,
Invoice_number int NOT NULL UNIQUE,
Date date NOT NULL,
Car int NOT NULL,
Customer int NOT NULL,
Salesperson int NOT NULL);
ALTER TABLE Cars
ADD CONSTRAINT cars_pk
PRIMARY KEY (ID);
ALTER TABLE Customers
ADD CONSTRAINT customer_pk
PRIMARY KEY (ID);
ALTER TABLE Salespersons 
ADD CONSTRAINT salespersons_pk
PRIMARY KEY (ID);
ALTER TABLE Invoices
ADD CONSTRAINT invoices_keys
PRIMARY KEY (ID);
ALTER TABLE Invoices
ADD FOREIGN KEY (Car) REFERENCES Cars(ID);
ALTER TABLE Invoices
ADD FOREIGN KEY (Customer) REFERENCES Customers(ID);
ALTER TABLE Invoices
ADD FOREIGN KEY (Salesperson) REFERENCES Salespersons(ID);


