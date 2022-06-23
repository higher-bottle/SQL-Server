-------------------------
--chapter2. SELECT语句
-------------------------

select prod_name from Products;--1. 从products表中检索prod_name的列

select prod_id,prod_name ,prod_price from Products;--2. 检索多个列，列与列之间用逗号隔开
select * from Products;--3. “*”通配符,表示检索所有的列

select distinct vend_id from Products;
select distinct prod_id,prod_name ,prod_price from Products;--4. distinct指示数据库只返回不同的值，只能放在列名之前且作用于所有输入的列


select top 5 prod_name from Products;--5. top <num>  限制返回前<num>行

select (100+200)*3 as calculation;--6.不使用 from

--挑战题
select cust_id from Customers;
select distinct prod_id from OrderItems;
select * from Customers;

------------------------------------------
--chapter3. SELECT [ORDER BY]子句（desc）
------------------------------------------
select prod_name from Products
order by prod_name;--order by 必须放在所有select语句的最后一句子句

select prod_id,prod_name ,prod_price from Products
order by prod_price, prod_name;--首先按价格排序，然后按名称排序

select prod_id,prod_name ,prod_price from Products
order by 2,3;--按照相对列排序

select prod_id,prod_name ,prod_price from Products
order by prod_price desc;--desc 为了降序排列

select prod_id,prod_name ,prod_price from Products
order by prod_price desc,prod_name;--desc只应用到直接位于其前面的列名

--挑战题
select cust_name from Customers order by cust_name desc;
select cust_id,order_num from Orders order by cust_id,order_num desc;
select item_price,quantity from OrderItems order by quantity desc,item_price desc;

---------------------------------------
--chapter4. SELECT [WHERE]子句：条件筛选
------------------------------------------
--where语句不能使用聚合函数
select prod_name,prod_price from Products
where prod_price=3.49;

select vend_id,prod_name from Products
where vend_id <> 'DLL01';--列出所有不是供应商DLL01制造的产品

select prod_name,prod_price from Products
where prod_price between 5 and 10;--检索在某一区间内的产品，是闭区间

select prod_name,prod_price from Products
where prod_price is null;--检索是否为空值

select * from Customers
where cust_email is null;--无法显示包含含有NULL值的行

--挑战题
select prod_id,prod_name from Products
where prod_price=9.49;

select prod_id,prod_name from Products
where prod_price>= 9;

select distinct order_num from OrderItems where quantity >= 100;

select prod_name,prod_price from Products where prod_price between 3 and 6 order by prod_price desc;

--------------------------------------
--chapter5. SELECT[ WHERE ]高级条件筛选
---------------------------------------
select prod_id,prod_price,prod_name from Products
where vend_id ='DLL01' and prod_price<=4;--可以不断叠加 and 来添加过滤条件

select prod_id,prod_price,prod_name from Products
where vend_id ='DLL01' or vend_id ='BRS01';--添加or表示“或者”

--在处理or操作符以前，优先处理and，
--圆括号具有比and或or操作符更高的优先级
select prod_name,prod_price from Products
where (vend_id='DLL01' or vend_id ='BRS01')
		and prod_price>=10;

select prod_name,prod_price from Products
where vend_id in ('DLL01','BRS01')
order by prod_name;--in （）完成了和or相同的工作，但是执行的更快

--not 可以用在要过滤的列前，不仅仅是列后，用来否定其后所跟的任何条件
select prod_name from Products
where not vend_id='DLL01'
order by prod_name;

--挑战题
select vend_name from Vendors
where vend_country='USA' and vend_state='CA';

select order_num,prod_id,quantity  from OrderItems
where prod_id in ('BR01','BR02','BR03') 
and quantity >= 100;

select prod_name,prod_price from Products
where prod_price between 3 and 6
order by prod_price desc;
