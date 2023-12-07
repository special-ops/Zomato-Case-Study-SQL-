drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-02-09'),
(2,'2015-12-01'),
(3,'2014-11-04');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-10',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

#1)what is the total amount each coustumer spent on zomato
 select s.userid, sum(p.price) total_amount_spent from sales  s inner join  product p on s.product_id = p.product_id group by (s.userid);
 
 
 #2)how many days each costumer visited zomato?
 select userid, count(distinct created_date) from sales group by userid;
 
 
 #3)what was the first product purchased by costumers? 
 
 (select * , rank() over(partition by userid order by created_date desc) rnk from sales);
 
 
 #4)what is the most purhased item in the menu and how many times it was bought by all the costumers with date?
 
 select userid, count(product_id) from sales where product_id=
( select product_id from sales group by product_id order by count(product_id)  desc limit 1) group by userid;

#5)which item is most popular for each costumer?
select * from(
(select *, rank() over(partition by userid order by cnt desc) rnk from 
(select userid,product_id, count(product_id) cnt from sales group by userid, product_id) as sks))  p
where rnk=1 ;
 


