-- query 1 Retrieve the name, account type, and email of all customers

select c.first_name, c.last_name, a.account_type, c.email
from customer c
join account a on c.id = a.customer_id;

-- Query 2 List all transactions corresponding to customers:
select t.*
from transaction t
join account a on t.account_id = a.id
join customer c on a.customer_id = c.id;

-- Query 3 increase the balance of a specific account by a certain amount (assuming the amount to increase is provided)

UPDATE account
SET balance = balance + (amount)
where id = (specific_account_id);

-- Query 4 Combine first and last names of customers as a full_name

select ConCAT(first_name, ' ', last_name) as full_name
from customer;

-- Query 5 Remove accounts with a balance of zero where the account type is savings

DELETE from account
where balance = 0 AND account_type = 'savings';

-- Query 6 Find customers living in a specific city

select *
from customer
where city = 'specific_city';

-- Query 7 Get the account balance for a specific account:

select balance
from account
where id = (specific_account_id);

-- Query 8 List all current accounts with a balance greater than $1,000

select *
from account
where account_type = 'current' AND balance > 1000;

-- Query 9 Retrieve all transactions for a specific account

select *
from transaction
where account_id = (specific_account_id);

-- Query 10 Calculate the interest accrued on savings accounts based on a given interest rate

select id, balance * (interest_rate) as interest_accrued
from account
where account_type = 'savings';

-- Query 11 Identify accounts where the balance is less than a specified overdraft limit

select *
from account
where balance < (overdraft_limit);

-- Query 12 Find customers not living in a specific city

# there is no table called city in customers

-- Query 13 Find the average account balance for all customers

select avg(balance) as average_balance
from account;

-- Query 14 Retrieve the top 10 highest account balances

select *
from account
order by balance desc
limit 10;

-- Query 15 Calculate Total Deposits for All Customers on a specific date

select sum(amount) as total_deposits
from transaction
where transaction_type = 'deposit'
AND transaction_date = '2024-03-01';

-- Query 16 Find the Oldest and Newest Customers:

select Min(dob) as oldest_customer_dob, MAX(dob) as newest_customer_dob
from customer;

-- Query 17 Retrieve transaction details along with the account type

select t.*, a.account_type
from transaction t
join account a on t.account_id = a.id;

-- Query 18 Get a list of customers along with their account details

select c.*, a.*
from customer c
join account a on c.id = a.customer_id;

-- Query 19 Retrieve transaction details along with customer information for a specific account

select t.*, c.*
from transaction t
join account a on t.account_id = a.id
join customer c on a.customer_id = c.id
where a.id = [specific_account_id];

-- Query 20 Identify customers who have more than one account

select customer_id
from account
group by customer_id
having count(*) > 1;

-- Query 21 Calculate the difference in transaction amounts between deposits and withdrawals


-- Query 22 Calculate the average daily balance for each account over a specified period

select account_id, avg(balance) as average_daily_balance
from account
group by account_id;

-- Query 23 Calculate the total balance for each account type

select account_type, sum(balance) as total_balance
from account
group by account_type;

-- Query 24 Identify accounts with the highest number of transactions ordered by descending order

select account_id, count(*) as transaction_count
from transaction
group by account_id
order by transaction_count desc;

-- Query 25 List customers with high aggregate account balances, along with their account types

select c.id, c.first_name, c.last_name, a.account_type, sum(a.balance) as total_balance
from customer c
join account a on c.id = a.customer_id
group by c.id
order by total_balance desc;

-- Query 26 Identify and list duplicate transactions based on transaction amount, date, and account

select transaction_type, amount, transaction_date, account_id, count(*) as duplicate_count
from transaction
group by transaction_type, amount, transaction_date, account_id
having count(*) > 1;

-- Query 27 Retrieve the customer(s) with the highest account balance

select *
from customer
where id = (select customer_id from account order by balance desc limit 1);

-- Query 28 Calculate the average account balance for customers who have more than one account

select AVG(sub.avg_balance) as average_balance
from (select AVG(balance) as avg_balance, customer_id
      from account
      group by customer_id
      having count(*) > 1) as sub;

-- Query 29 Retrieve accounts with transactions whose amounts exceed the average transaction amount

select *
from account
where id in (select distinct account_id
             from transaction
             where amount > (select AVG(amount) from transaction));

-- Query 30 Identify customers who have no recorded transactions

select *
from customer
where id NOT in (select distinct customer_id from transaction);

-- Query 31 Calculate the total balance of accounts with no recorded transactions

select sum(balance) as total_balance_no_transactions
from account
where id NOT in (select distinct account_id from transaction);

-- Query 32 Retrieve transactions for accounts with the lowest balance

select *
from transaction
where account_id = (select id from account order by balance asC limit 1);

-- Query 33 Identify customers who have accounts of multiple types

select distinct c.id, c.first_name, c.last_name
from customer c
join account a ON c.id = a.customer_id
group by c.id
having count(distinct a.account_type) > 1;

-- Query 34 Calculate the percentage of each account type out of the total number of accounts

select account_type, count(*) * 100.0 / (select count(*) from account) as percentage
from account
group by account_type;

-- Query 35 Retrieve all transactions for a customer with a given customer_id

select *
from transaction
where account_id in (select id from account where customer_id = (customer_id));

-- Query 36 Calculate the total balance for each account type, including a subquery within the select clause

select account_type,
       (select sum(balance) from account where account_type = a.account_type) as total_balance
from account a
group by account_type;




