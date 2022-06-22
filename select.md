* [chapter 01. SELECT语句](https://github.com/higher-bottle/SQL-Server/edit/main/select.md#chapter-01-select%E8%AF%AD%E5%8F%A5)
  * [基础SELECT语句](https://github.com/higher-bottle/SQL-Server/edit/main/select.md#%E5%9F%BA%E7%A1%80select%E8%AF%AD%E5%8F%A5)
  	* [DISTINCT](https://github.com/higher-bottle/SQL-Server/edit/main/select.md#distinct%E6%8C%87%E7%A4%BA%E6%95%B0%E6%8D%AE%E5%BA%93%E5%8F%AA%E8%BF%94%E5%9B%9E%E4%B8%8D%E5%90%8C%E7%9A%84%E5%80%BC%E5%8F%AA%E8%83%BD%E6%94%BE%E5%9C%A8%E5%88%97%E5%90%8D%E4%B9%8B%E5%89%8D%E4%B8%94%E4%BD%9C%E7%94%A8%E4%BA%8E%E6%89%80%E6%9C%89%E8%BE%93%E5%85%A5%E7%9A%84%E5%88%97)
   	 * [TOP](https://github.com/higher-bottle/SQL-Server/edit/main/select.md#top---%E9%99%90%E5%88%B6%E8%BF%94%E5%9B%9E%E5%89%8D%E8%A1%8C)

-------------------------
chapter 01. SELECT语句
-------------------------
### 基础SELECT语句
 从products表中检索prod_name的列

```sql
select prod_name from Products;
```

检索多个列，列与列之间用逗号隔开
```sql
select prod_id,prod_name ,prod_price from Products;
```
“*”是通配符\
##### DISTINCT指示数据库只返回不同的值，只能放在列名之前且作用于所有输入的列

```sql
select distinct vend_id from Products;
select distinct prod_id,prod_name ,prod_price from Products;
```
##### TOP <num>  限制返回前…行
```sql
select top 5 prod_name from Products;
```

也可以不使用 from（直接计算）
```sql
select (100+200)*3 as calculation;
```

>ex.
```sql
select cust_id from Customers;
select distinct prod_id from OrderItems;
select * from Customers;
```

### ORDER BY子句

```sql
select prod_name from Products
order by prod_name;
```
***order by 必须放在所有select语句的最后一句子句***
```sql
select prod_id,prod_name ,prod_price from Products
order by prod_price, prod_name;--首先按价格排序，然后按名称排序
```
```sql
select prod_id,prod_name ,prod_price from Products
order by 2,3;--按照相对列排序(不推荐)
```
```sql
select prod_id,prod_name ,prod_price from Products
order by prod_price desc;
```
***DESC 为了降序排列***
select prod_id,prod_name ,prod_price from Products
order by prod_price desc,prod_name;--desc只应用到直接位于其前面的列名

>ex.
```sql
select cust_name from Customers order by cust_name desc;
select cust_id,order_num from Orders order by cust_id,order_num desc;
select item_price,quantity from OrderItems order by quantity desc,item_price desc;
```

### WHERE子句——条件筛选
***where语句不能使用聚合函数***
```sql
select prod_name,prod_price from Products
where prod_price=3.49;
```
>逻辑变量
	
| Syntax      | Description |
| ----------- | ----------- |
| =      | 等于        |
| <      | 小于        |
| >      | 大于        |
| >=     | 大于等于    |
| <=     | 小于等于    |
| <>     | 不等于      |
| !=     | 不等于      |
| IS NULL| 是空值      |
|IS NOT NULL| 不是空值 |

```sql
select vend_id,prod_name from Products
where vend_id <> 'DLL01';--列出所有不是供应商DLL01制造的产品
```
```sql
select prod_name,prod_price from Products
where prod_price between 5 and 10;
```
***检索在某一区间内的产品，是闭区间***
```sql
select prod_name,prod_price from Products
where prod_price is null;
```
>ex.
```sql
select prod_id,prod_name from Products
where prod_price=9.49;

select prod_id,prod_name from Products
where prod_price>= 9;

select distinct order_num from OrderItems where quantity >= 100;

select prod_name,prod_price from Products where prod_price between 3 and 6 order by prod_price desc;
```

### AND/OR 高级条件筛选
***可以不断叠加 AND 来添加过滤条件***
```sql
select prod_id,prod_price,prod_name from Products
where vend_id ='DLL01' 
and prod_price<=4;
```
```sql
select prod_id,prod_price,prod_name from Products
where vend_id ='DLL01' 
or vend_id ='BRS01';
```
***添加or表示“或者”***
***在处理or操作符以前，优先处理and***
***圆括号()具有比and或or操作符更高的优先级***
```sql
select prod_name,prod_price from Products
where (vend_id='DLL01' or vend_id ='BRS01')
		and prod_price>=10;
```
***in （）完成了和or相同的工作，但是执行的更快***
```sql
select prod_name,prod_price from Products
where vend_id in ('DLL01','BRS01')
order by prod_name;
```
***NOT 可以用在要过滤的列前，不仅仅是列后，用来否定其后所跟的任何条件:***
```sql
select prod_name from Products
where not vend_id='DLL01'
order by prod_name;
```
>ex.
```sql
select vend_name from Vendors
where vend_country='USA' and vend_state='CA';

select order_num,prod_id,quantity  from OrderItems
where prod_id in ('BR01','BR02','BR03') 
and quantity >= 100;

select prod_name,prod_price from Products
where prod_price between 3 and 6
order by prod_price desc;
```
--------------------------------------
chapter 02. 用通配符进行过滤 LIKE操作符
---------------------------------------
*通配符搜索只用于***文本字段（字符串）***，非文本数据类型字段不能使用通配符搜索；*

**在搜索串中，%表示任何字符出现任意次数**
```sql
select prod_id,prod_name from Products
where prod_name like 'Fish%';--检索任意以Fish起头的词

select prod_id,prod_name from Products
where prod_name like '%bean bag%';--检索任意 bean bag在当中的词语

select prod_id,prod_name from Products
where prod_name like 'F%y';
```
***下划线_的用途与%一样，但只匹配单个字符。***
```sql
select prod_id,prod_name from Products
where prod_name like '__ inch teddy bear';
```
***[ ]用来指定一个字符集，他必须匹配指定位置的一个字符（只能匹配单个字符）***
```sql
select cust_contact from Customers
where cust_contact like '[JM]%';--找出所有名字以J或M起头的联系人
```
***^（脱字号***
```sql
select cust_contact from Customers
where cust_contact like '[^JM]%';--用^（脱字号）来否定，匹配以J和M以外的任意字符起头的任意联系人名

--也可以这么表示：
select cust_contact from Customers
where 
not cust_contact like '[JM]%';
```
>ex.
```sql
select prod_name,prod_desc from Products
where prod_desc like '%toy%';

select prod_name,prod_desc from Products
where not prod_desc like '%toy%'
order by prod_name;

select prod_name,prod_desc from Products
where prod_desc like '%toy%' and prod_desc like'%carrots%';

select prod_name,prod_desc from Products
where prod_desc like '%toy%carrots%';
```
