-- List all customers and their account creation dates.
select account_id, occurred_at
from web_events;

-- show all orders placed in 2016
select id, account_id, occurred_at, total_amt_usd
from orders
where extract (year from occurred_at) = 2016
order by occurred_at;

-- Find the total quantity of paper sold for each paper type.
select sum (standard_qty) as total_standard, sum (gloss_qty), sum (poster_qty)
from orders;

-- customer to make the first order
select a.name as customer_name, o.occurred_at as first_order_date, o.id as order_id
from orders o
join accounts a
on o.account_id = a.id
order by o.occurred_at
limit 1;

-- List all distinct sales reps and the regions they cover
select distinct s.name as sales_rep, r.name as region
from sales_reps s
join region r
on s.region_id = r.id;

-- Find the number of customers in each region.
select r.name as region, count (a.name) as customers_count
from accounts a
left join sales_reps s
on a.sales_rep_id = s.id
left join region r
on s.region_id = r.id
group by region;

-- List all distinct sales reps and the regions they cover.
select s.name as sales_rep, r.name as region
from sales_reps s
join region r 
on s.region_id = r.id
order by region, sales_rep;

-- Show all orders that include “poster” paper.
select o.id as order_id, a.name as customer_name, o.occurred_at, o.poster_qty, o.total_amt_usd
from orders o
join accounts a
on o.account_id = a.id
where poster_qty > 0
order by occurred_at;

-- get all customer(s) who don't have any orders
select a.id AS account_id, a.name AS customer_name
from accounts a
left join orders o
on a.id = o.account_id
where o.id is null
order by a.name;

