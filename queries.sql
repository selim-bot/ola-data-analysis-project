CREATE DATABASE OlaDB;
USE OlaDB;

CREATE TABLE Bookings (
    Date TEXT,
    Time TEXT,
    Booking_ID TEXT,
    Booking_Status TEXT,
    Customer_ID TEXT,
    Vehicle_Type TEXT,
    Pickup_Location TEXT,
    Drop_Location TEXT,
    V_TAT TEXT,
    C_TAT TEXT,
    Canceled_Rides_by_Customer TEXT,
    Canceled_Rides_by_Driver TEXT,
    Incomplete_Rides TEXT,
    Incomplete_Rides_Reason TEXT,
    Booking_Value TEXT,
    Payment_Method TEXT,
    Ride_Distance TEXT,
    Driver_Ratings TEXT,
    Customer_Rating TEXT,
    Vehicle_Images TEXT
);


SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bookings.csv'
INTO TABLE Bookings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- QUERY-- 
SELECT Canceled_Rides_by_Customer FROM bookings;
SELECT * FROM bookings;
SELECT Vehicle_Images,Ride_Distance,Driver_Ratings FROM bookings WHERE Customer_Rating >=4;
SELECT Booking_ID ,Canceled_Rides_by_CustomerPickup_Location FROM bookings WHERE Canceled_Rides_by_Customer="null";


-- RETRIVE ALL THE SUCCESFUL  BOOKING  --

CREATE VIEW  Succesful_Booking AS 
SELECT * FROM Bookings WHERE Booking_Status='Success';
SELECT * FROM Succesful_Booking;


-- FIND THE AVARAGE RIDE DISTANCE FOE EACH VEHICAL TYPE--
CREATE VIEW  AVARAGE_RIDE_DISTANCE AS
SELECT Vehicle_Type,AVG(Ride_Distance) AS
AVG_DISTANVE FROM bookings GROUP BY Vehicle_Type;

SELECT * FROM AVARAGE_RIDE_DISTANCE;

-- COUNT OF THE CHANCEL BOOKIING--

CREATE VIEW NO_OF_RIDE_CANCEL_BY_CUSTOMER AS
SELECT COUNT(*) FROM bookings 
WHERE Booking_Status ='Canceled by Customer'; 


-- LIST THE TOP 5 CUSTOMER WHO BOOKED THE HEIGEST NUMBER OF BOOKING-- 

CREATE VIEW TOP_5_CUSTOMER AS
SELECT Customer_ID,COUNT(Booking_ID) AS TOTAL_RIDE
FROM bookings
GROUP BY Customer_ID
ORDER BY TOTAL_RIDE DESC LIMIT 5;

SELECT * FROM TOP_5_CUSTOMER;

-- GET THE NUMBER OF THE RIDES CANCELED BY DRIVER DUE TO PERSONAL AND CAR RELETED ISSUE -- 
CREATE VIEW CRBD AS 
SELECT COUNT(*) FROM bookings WHERE Canceled_Rides_by_Driver='Personal & Car related issue';

select * FROM CRBD;
select * from bookings;

-- FIND THE MIINIMUN AND THE MAXXIMUM RATING OF DRIVER OF Prime Sedan booking-- 

CREATE VIEW  MAX_MIN  AS
SELECT MAX(Driver_Ratings) AS MAX_RATING,
MIN(Driver_Ratings) AS MIN_RATING
FROM bookings
WHERE Vehicle_Type='Prime Sedan';


-- RETRIVE ALL THE RIDE WHERE THE RIDES ARE MADE UP BY UPI--
CREATE VIEW UPI AS
SELECT * FROM bookings
 WHERE Payment_Method='UPI'; 
 
SELECT * FROM UPI;



-- FIND THE CUSTOMER RATIING AVRAGE AS PER VEHICAL TYPE-- 
CREATE VIEW CUSOMER_RATING_EACH_VEHICAL AS
SELECT Vehicle_Type,AVG(Customer_Rating) AS CUSTOMER_RATING 
FROM bookings GROUP BY Vehicle_Type;



-- TOTAL BOOKING WHICH IS COMPLETED-- 
CREATE VIEW TOTAL_COMPLETE_BOOKINGS AS
SELECT SUM(Booking_Value) AS TOTAL_BOOKING
 FROM bookings
 WHERE Booking_Status='success';
 
 select * from  TOTAL_COMPLETE_BOOKINGS;
 
 
 -- list all the imcomplete ride with the reason-- 
 CREATE VIEW REASON_INCOMPLETE_RIDES AS
 SELECT Booking_ID,Incomplete_Rides_Reason FROM bookings WHERE Incomplete_Rides='YES';
 
 