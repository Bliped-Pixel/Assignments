
# Task 2
-- Query 1 Write a SQL to insert at least 10 sample records into each table

insert into venue(venue_name,address) 
values 
		('mumbai', 'marol andheri(w)'),
		('chennai', 'IT Park'),
		('pondicherry ', 'state beach'),
		('chennai', 'Marina'),
		('pondicherry ', 'rock beach'),
		('chennai', 'Anna nagar'),
		('pondicherry ', 'White town'),
		('mumbai', 'IT Park'),
		('chennai', 'Central'),
		('mumbai', 'mumbai beach');
insert into customer(customer_name,email,phone_number) 
values
		('harry potter','harry@gmail.com','4543244512'),
		('ronald weasley','ron@gmail.com','4545454543'),
		('hermione granger','her@gmail.com','4545454565'),
		('draco malfoy','drac@gmail.com','4545454509'),
		('ginni weasley','ginni@gmail.com','4545454587'),
		('james sirius potter','jamesharry@gmail.com','4545454510'),
		('fred weasley','fredgeorge@gmail.com','4545454551'),
		('rose granger','rose@gmail.com','4545453245'),
		('scorpious malfoy','scordrac@gmail.com','4545454985'),
		('george weasley','georgefred@gmail.com','4545454305');
		insert into event(event_name,event_date,event_time,total_seats,available_seats,ticket_price,event_type,venue_id)
		values 
		('Late Ms. Lata Mangeshkar Musical', '2021-09-12','20:00',320,270,600,'concert',3),
		('CSK vs RCB', '2024-04-11','19:30',23000,3,3600,'sports',2),
		('CSK vs RR', '2024-04-19','19:30',23000,10,3400,'sports',7),
		('MI vs KKR', '2024-05-01','15:30',28000,100,8000,'sports',4),
		('MI vs RCB', '2024-04-12','19:30',23000,30,3600,'sports',9),
		('CSK vs MI', '2024-05-19','20:00',23000,10,3700,'sports',8),
		('MI vs RR', '2024-05-02','15:30',28000,120,8000,'sports',6),
		('AR Rahman Musical', '2024-01-12','18:00',3200,200,1600,'concert',5),
		('Home Alone 1 re-release', '2024-02-28','16:00',300,50,200,'movie',4),
		('Cars 2006 re-release', '2024-03-01','12:00',320,100,170,'movie',10),
		('Fantastic beast', '2024-03-28','16:00',400,150,200,'movie',4),
		('Harry potter and the goblet of fire', '2024-03-11','12:00',340,10,170,'movie',1);
insert into booking 
values 
		(4,1,2,640,'2021-09-12'),
		(4,4,3,960,'2021-09-12'),
		(5,1,3,10800,'2024-04-11'),
		(5,3,5,18000,'2024-04-10'),
		(6,5,10,34000,'2024-04-15'),
		(7,2,4,32000,'2024-05-01');

-- Query 2 Write a SQL query to list all Events.
select * from event; 

--  Query 3 Write a SQL query to select events name partial match with ‘cup’.
select * 
from event
where event_name LIKE '%Musical%';

-- Query 4 Write a SQL query to retrieve events with dates falling within a specific range

select * 
from event
where event_date BETWEEN '2024-04-11' AND '2024-05-01';

-- Query 5 Write a SQL query to select events with ticket price range is between 1000 to 2500

select * from event where ticket_price between 1000 and 2500;

-- Query 6 Write a SQL query to retrieve events with dates falling within a specific range

select * from event where event_date between '2024-03-01' and '2024-04-01';

-- Query 7 Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.

select * from events where available_seats > 0 and event.name like '%Musical%';

-- Query 8 Write a SQL query to retrieve customers in batches of 5, starting from the 6th user.

select * 
from customer
limit 3,2;

-- Query 9 Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.

select * 
from booking 
where num_tickets > 4; #records 6-10

-- Query 10 Write a SQL query to retrieve customer information whose phone number end with ‘000’

select * 
from customer 
where phone_number LIKE '%000'; # ends number with 000 

-- Query 11 Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
select * 
from event
where total_seats > 15000
order by total_seats ASC ; 

-- Query 12 Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’

select * 
from event
where event_name NOT LIKE 'c%' AND event_name NOT LIKE 'x%'; 

-- Query 13 display list of events hosted by venue 'chennai'.

select e.id,e.event_name,e.event_date,e.event_time,e.total_seats
from event e,venue v
where v.id = e.venue_id AND v.venue_name='chennai';

-- Query 14 select customers that have booked tickes for event 'csk v rcb'  game with id=5; 

select c.customer_name,email,phone_number
from customer c, booking b
where c.id = b.customer_id AND b.event_id=5;

-- Query 15 display event details that have booking num_tickets > 1000

select b.event_id,b.num_tickets
from event e , booking b
where e.id = b.event_id AND b.num_tickets > 5;


/* 
	Query 16 Display the names of venues visited by customer with email 'harry@gmail.com'
*/

select v.venue_name,v.address,c.customer_name
from venue v,booking b,event e,customer c
where v.id=e.venue_id AND 
e.id = b.event_id AND 
b.customer_id = c.id AND 
c.email='harry@gmail.com';

/* 
. Query 17 Write a SQL query to List Venues and Their Average Ticket Prices.
-  Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
*/

select e.venue_id,v.venue_name,AVG(e.ticket_price ) 
from event e, venue v
where v.id = e.venue_id
group by e.venue_id;

#note: We can join multiple tables like venue and fetch extra info from there like venue_name. 

/* 
	Query 18 Write a SQL query to Calculate the Total Revenue Generated by Events.
*/

select SUM((total_seats  - available_seats) *  ticket_price) #We can perform arithmetic ops in select statement
from event;

/* 
	Query 19 Write a SQL query to find the event with the highest ticket sales
*/

select event_name,MAX((total_seats  - available_seats) *  ticket_price) as total_sales
from event
group by event_name
order by total_sales DESC
limit 0,1;

/*
Query 20 Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
*/

select event_name, total_seats  - available_seats as total_tickets_sold
from event 
group by event_name;

/* 
. Query 21 Write a SQL query to Find Events with No Ticket Sales.
*/

/* 
Write a SQL query to Find the Customer Who Has Booked the Most Tickets.
*/

#plan: first, find the tickets booked by each customer. then find the most 

select customer_name, SUM(b.num_tickets) as tickets_booked 
from booking b, customer c
where b.customer_id = c.id
group by customer_name
order by tickets_booked DESC
limit 0,1;

/*
	Query 22 Write a SQL query to calculate the total Number of Tickets Sold for Each Event Typ
*/

/*
	 Query 23 Write a SQL query to list customer who have booked tickets for multiple events.
*/

#plan- first display all customer_name and event_name with seats booked and then
#step 2: I will find those customers who have booked for multiple events

select e.event_name, c.customer_name, b.num_tickets
from event e,customer c, booking b
where e.id = b.event_id AND 
b.customer_id = c.id; 

# step 2: I vl group by customer_name to get info of number_of events booked. 

select c.customer_name , count(c.id) as events_booked
from event e,customer c, booking b
where e.id = b.event_id AND 
b.customer_id = c.id
group by c.customer_name ;

 
 #now I vl display the records that have events_booked>1
 select c.customer_name , count(c.id) as events_booked
from event e,customer c, booking b
where e.id = b.event_id AND 
b.customer_id = c.id
group by c.customer_name 
having events_booked>1;


-- step 1: Join and bring the tables togather. 
select * 
from  event e  JOIN booking b  ON e.id = b.event_id JOIN  customer c ON c.id = b.customer_id;

-- step 2: group by customer name as we need to compute revenue for each customer which will
-- give customer_name and number of bookings 

select c.customer_name, count(c.id) as Number_Of_bookings
from  event e  JOIN booking b  ON e.id = b.event_id JOIN  customer c ON c.id = b.customer_id
group by c.customer_name;

-- Step 3: We need to calculate sum of total couse for each customer, so updating above query 
select c.customer_name as Customer_Name, sum(b.total_cost) as Revenue
from  event e  JOIN booking b  ON e.id = b.event_id JOIN  customer c ON c.id = b.customer_id
group by c.customer_name
order by Revenue DESC;


-- 14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the 
 -- Last 30 Days.
 
select c.customer_name, SUM(b.num_tickets) as Number_Of_tickets
from  event e  JOIN booking b  ON e.id = b.event_id JOIN  customer c ON c.id = b.customer_id
where b.booking_date between DATE_SUB('2024-04-30',INTERVAL 30 DAY) and  '2024-04-30'
group by c.customer_name;

-- now() gives todays date 
 

/* 
Q. Names of Customers who have visited venue 'chennai' using all three techniques(Nested Query).
*/

select id,customer_name
from customer 
where id IN (select customer_id 
			 from booking
			 where event_id IN (select id 
								from event
                                where venue_id IN (select id
												   from venue 
                                                   where venue_name='chennai')));

-- Task 4: Subquery and its types

/* 
1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
*/

select venue_id,AVG(ticket_price) as Avg_Price
from event
where venue_id IN (select id from venue) 
group by venue_id;

/* 
2. Find Events with More Than 50% of Tickets Sold using subquery.
*/
select event_name
from event
where id IN ( select id 
			  from event 
              where (total_seats - available_seats) > (total_seats/2));

/* 
3. Find Events having ticket price more than average ticket price of all events  
*/

select event_name
from event 
where ticket_price >  (select avg(ticket_price) from event); 
 
 /* 
 4. Find Customers Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
 */
 
 insert into customer(customer_name,email,phone_number) 
 values ('severus snape', 'sev@gmail.com','56556');
 
 select * from customer; 
 
 -- SELECT column1 FROM t1 WHERE EXISTS (TABLE t2);

# if there is even 1 row in table t2 then the where clause condition is evaluated to true. 

 select customer_name
 from customer
 where NOT EXISTS (select distinct c.customer_name
				from customer c join booking b ON b.customer_id = c.id);
 
 
 select distinct c.customer_name
				from customer c join booking b ON b.customer_id = c.id; 
                
                
                
/* 
Display customer details having email 'harry@gmail.com' provided this customer  
has attended atleast 1 event. 
*/     
 
select * 
from customer 
where EXISTS (select distinct c.id 
			  from customer c join booking b ON c.id=b.customer_id 
              where c.email='harry@gmail.com')  
AND email='harry@gmail.com';

select * 
from customer 
where EXISTS (select distinct c.id 
			  from customer c join booking b ON c.id=b.customer_id 
              where c.email='sev@gmail.com')  
AND email='sev@gmail.com';






