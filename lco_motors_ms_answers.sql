
show databases;
use lco_motors;

select * from customers;
select * from employees;
select * from offices;
select * from orderdetails;
select * from orders;
select * from payments;
select * from productlines;
select * from products;


#Q1
select * from customers c
left join orders o                        
on c.customer_id = o.customer_id 
where `status` = 'cancelled';

#select * from orders where `status`='cancelled';

-----------------------------------------------------------------------------------------------
#Q2
select * from customers c
inner join
payments p on c.customer_id=p.customer_id
where amount between 5000 and 35000;

#select * from payments where amount between 5000 and 35000;

---------------------------------------------------------------------------------------------------
#Q3
insert into employees(employee_id,last_name,first_name,extension,email,office_code,reports_to,job_title)
values ('15657','Lakshmi','Roy','x4065','lakshmiroy1@lcomotors.com','4','1088','Sales Rep');

#select * from employees where employee_id=15657;


---------------------------------------------------------------------------------------------
#Q4
#select * from customers where phone=2125557413;

update customers
set sales_employee_id = 15657
where phone = 2125557413;

set sql_safe_updates = 0;   # if error comes while exicuting above update query.

----------------------------------------------------------------------------------------------
#Q5
select * from products as p
inner join 
orderdetails as od on p.product_code=od.product_code
inner join
orders as o on od.order_id=o.order_id
where p.product_line='Motorcycles' and o.`status`='Shipped';

---------------------------------------------------------------------------------------------
#Q6
select * from employees where office_code in (select office_code from offices where city='Sydney');

#select office_code from offices where city='Sydney';
#select * from employees where office_code =6;

----------------------------------------------------------------------------------------------------------------------
#Q7
select * from customers where customer_id in (select customer_id from orders where `status`='In process');

#select distinct(`status`) from orders;
#select * from orders where `status`='in process';

-------------------------------------------------------------------------------------------------------------------------
#Q8
#select * from orderdetails where quantity_ordered <30;
select * from products as p
inner join orderdetails as od on p.product_code = od.product_code
where od.quantity_ordered <30;

----------------------------------------------------------------------------------------------------------------------------
#Q9
update payments
set amount = 2575
where check_number ='OM314933';

-----------------------------------------------------------------------------------------------------------------------------
#Q10
#select * from orders where `status`='resolved';

select employee_id, e.first_name, e.last_name, e.office_code, e.email, o.order_id, c.customer_id, o.`status` from employees as e
inner join
customers as c on e.employee_id = c.sales_employee_id
inner join 
orders as o on c.customer_id = o.customer_id
where `status`='resolved';

------------------------------------------------------------------------------------------------------------------------------------------
#Q11
#select count(customer_id) from payments group by customer_id order by count(customer_id) desc;

select * from customers as c
right join payments as p on c.customer_id = p.customer_id
group by p.customer_id order by count(p.customer_id) desc limit 1;


----------------------------------------------------------------------------------------------------------------------------------------------
#Q12
select * from orders where `status`='shipped' and customer_id in 
(select customer_id from customers where country ='france');

--------------------------------------------------------------------------------------------------------------------------------------------------------
#Q13
select customer_id from customers where country ='finland'; #and customer_id in (select customer_id from orders ) ;
select order_id, customer_id, count(customer_id) as total from orders where customer_id in 
(select customer_id from customers where country='finland') group by customer_id;

----------------------------------------------------------------------------------------------------------------------------------------------------
#Q14
# same as Q11

------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q15
select * from customers as c
inner join
payments as p on c.customer_id = p.customer_id
where payment_date between '2019-05-01' and '2019-06-30';

---------------------------------------------------------------------------------------------------------------------------------------------------
#Q16
select count(order_id) from orders
where shipped_date like '2018%' and customer_id in 
(select customer_id from customers where country ='belgium');

------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q17
#select * from customers where country ='germany';

select e.employee_id, e.last_name, e.first_name, e.office_code, e.job_title, o.city, o.country, o.office_code, o.address_line1, o.address_line2 from employees as e
inner join
customers as c on e.employee_id = c.sales_employee_id
inner join
offices as o on e.office_code = o.office_code
where c.country = 'germany';

-------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q18
#select * from orders order by order_id desc;

# solution one
INSERT INTO `orders` (`order_id`, `order_date`, `required_date`, `shipped_date`, `status`, `comments`, `customer_id`)
VALUES (10426,current_date(),(current_date()+ interval 10 day),0,'In process',0,496);

update orders
set shipped_date = null
where order_id = 10426;

update orders
set comments = null
where order_id = 10426;

delete from orders
where order_id = 10426;

#solution two
INSERT INTO `orders` (`order_id`, `order_date`, `required_date`, `status`, `customer_id`)
VALUES (10426,current_date(),(current_date()+ interval 10 day),'In process',496);

--------------------------------------------------------------------------------------------------------------------------------------------------
#Q19   
select e.employee_id, e.last_name, e.first_name, e.office_code, e.job_title  from employees as e
inner join
customers as c on e.employee_id = c.sales_employee_id
inner join
payments as p on c.customer_id = p.customer_id
where payment_date between '2018-06-01' and '2018-07-31';

#select * from payments where payment_date between '2018-06-01' and '2018-07-31';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q20
INSERT INTO `payments` (`customer_id`, `check_number`, `payment_date`, `amount`) VALUES
(119,'OM314944',current_date(),33789.55);

---------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q21
select address_line1, address_line2, city, country, postal_code, phone from offices where office_code in 
(select distinct(office_code) from employees where reports_to =1102);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q22
select p.customer_id, p.check_number, p.payment_date, p.amount, pd.product_line from payments as p
inner join 
orders as o on p.customer_id = o.customer_id
inner join
orderdetails as od on o.order_id = od.order_id
inner join
products as pd on od.product_code = pd.product_code
where pd.product_line = 'classic cars';

#select * from products where product_line = 'classic cars';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q23
select count(distinct(o.customer_id)) from orders as o where customer_id in 
(select customer_id from customers where country = 'usa');
    
#select * from customers where country = 'usa';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q24
select comments, customer_id from orders where `status`='resolved';

#select count(*), `status` from orders group by `status`;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q25
select e.employee_id, e.last_name, e.first_name, e.office_code, e.job_title, o.address_line1, o.address_line2 from employees as e
left join
offices as o on e.office_code = o.office_code
where o.country = 'usa';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q26
select product_code, quantity_ordered, each_price,quantity_ordered * each_price as total_price from orderdetails where product_code in
(select product_code from products where product_line = 'motorcycles');

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q27
select sum(quantity_ordered * each_price) as total_planes_price from orderdetails where product_code in
(select product_code from products where product_line = 'planes');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q28
select count(*) from customers where country = 'france';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q29
select * from payments where customer_id in 
(select customer_id from customers where country = 'france');

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Q30
select address_line1, address_line2, city, country, postal_code, phone from offices where office_code in 
(select office_code from employees where reports_to =1143);

