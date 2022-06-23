--------------------------------------
--chapter7. 创建计算字段
---------------------------------------
select vend_name + '('+ vend_country +')'
from Vendors
order by vend_name;--拼接

select rtrim(vend_name) + '('+ vend_country +')'
from Vendors
order by vend_name;--rtrim()函数去掉了值右边所有空格，trim()去掉了左边所有空格

select rtrim(vend_name) + '('+ vend_country +')'
as vend_title
from Vendors
order by vend_name;--用as赋予别名

select prod_id,quantity,item_price,quantity*item_price as expended_price
from OrderItems
where order_num=20008;--对检索出的数据进行算术计算

--挑战题
select vend_id,
		vend_name as vname,
		vend_address as vaddress,
		vend_city as vcity 
from Vendors
order by vend_name;

select prod_id,prod_price,
		prod_price*0.9 as sale_price 
from Products;

--------------------------------------
--chapter8. 使用函数处理数据
---------------------------------------
select vend_name,UPPER(vend_name) as vend_name_upcase
from Vendors
order by vend_name;--upper()将文本转换为大写

/* 常用文本处理函数
left()				返回字符串左边的字符
length()/len()		返回字符串长度
lower()				将字符串转化为小写
ltrim				去掉字符串左边的空格
substr()/substring()提取字符串的组成部分
soundex()			返回字符串的soundex值（soundex是一个将任何文本串转换为描述其语音表示的字母数字模式的算法）
*/
select cust_name,cust_contact from Customers
where SOUNDEX(cust_contact)=SOUNDEX('Michael Green');

select order_num from Orders
where DATEPART(yy,order_date)=2020;--datepart()返回日期的一部分

/*常用我的数值处理函数
abs()			返回一个数的绝对值
cos()			返回一个角度的余弦
exp()			返回一个数的指数值
pi()			返回圆周率Π的值
sqrt()			返回一个数的平方根
*/

select cust_id,cust_name,
		upper(rtrim(SUBSTRING(cust_contact,1,2)) + SUBSTRING(cust_city,1,3) ) as user_login
		from Customers;

select order_num,order_date 
from Orders
where DATEPART(yy,order_date)=2020 and DATEPART(MM,order_date)=1
order by order_date;


--------------------------------------
--chapter9. 聚集函数
---------------------------------------
/*聚集函数
avg()			返回某列均值
count()			返回某列行数
max()			返回某列最大值
min()
sum()			返回某列值之和
*/
select avg(prod_price) as avg_price
from Products;

select avg(prod_price) as avg_price
from Products
where vend_id='DLL01';--avg()只能应用于单个列，如果需要多列的数据，需要每个列都用avg()

--count(*)返回表中行的数目，不管是否包含NULL；
--count(column)返回的是特定列具有值的行的数目
select COUNT(*) as num_cust
from Customers;

select COUNT(cust_email) as num_cust
from Customers;

select sum(quantity) as items_ordered
from OrderItems
where order_num=20005;

select sum(item_price*quantity) as total_price
from OrderItems
where order_num=20005;--sum()可以合计计算值

select avg(distinct prod_price) as avg_price
from Products
where vend_id='DLL01';--distinct()必须使用列名


--select可以包含多个聚集函数
select count(*) as num_items,
		min(prod_price) as price_min,
		max(prod_price) as price_max,
		avg(prod_price) as price_avg
from Products;

--挑战题
select sum(quantity) from OrderItems;
select sum(quantity) from OrderItems
where prod_id='BR01';

select max(prod_price) as max_price
from Products
where prod_price<=10;
