 -- in addition
 SELECT 
   first_name,
  last_name,
    position,
  employment_date,
    bonus
FROM 
  employee
WHERE 
   bonus IS NULL
AND
  -- month(employment_date) = 11 
 employment_date like'%-11-%' 
order by 
  last_name ASC;

USE company;

/* Exs 5.1/. Отримати інформацію з таблиці employee про співробітників, 
які працюють на керівних посадах ('CEO', 'Manager’).*/

SELECT 
employee_id "Manager ID", 
last_name "Manager Last Name", 
first_name 'Manager First Name', 
position 'Manager Title', 
employment_date AS 'Manager Hire Date'
FROM
	employee AS Managers 
WHERE 
	position IN ('CEO', 'Manager');
    
   /* Exs 5.2. Отримати інформацію з таблиці employee про співробітників та їхніх керівників.
Розширити попередній запит, перейменувавши заголовки таблиць Працівники, Менеджери
Добапити в вибірку інформацію про працівників*/

SELECT 
	  e.employee_id "Employee ID",
	 e.last_name "Employee Last Name", 
	 e.first_name 'Employee First Name', 
	 e.position 'Employee Title',
	 e.employment_date AS 'Employee Hire Date', 
	 e.manager_id "Employee Manager ID",
	 m.employee_id "Manager ID", 
	 m.last_name "Manager Last Name",
	 m.first_name 'Manager First Name', 
	 m.position 'Manager Title', 
	 m.employment_date AS 'Manager Hire Date' 
 FROM
	employee AS e, 
	employee AS m 
 WHERE 
	e.manager_id = m.employee_id;
    
    
    /*Exs 5.3.Отримати інформацію з таблиць employee department про співробітників та відділи.
Змінити попередній запит, перейменувавши заголовки таблиць Працівники, Департамент
Добавити в вибірку інформацію про департаменти*/
    SELECT 
		e.employee_id "Employee ID", 
		e.last_name "Employee Last Name", 
		e.first_name 'Employee First Name',
		e.position "Employee Title",
		e.department_id "Employee Department ID", 
		d.department_id "Department ID", 
		d.department_name "Department name" 
    FROM 
		employee AS e,
        department AS d
    WHERE 
		 e.department_id= d.department_id;
         
         /* Exs 5.4. Отримати інформацію з таблиць employee, invoice про співробітників та дату транзакції.
Змінити попередній запит, добавивши в вибірку інформацію про продажі*/
	SELECT 
		e.employee_id "Employee ID", 
         e.last_name "Employee Last Name", 
         e.first_name 'Employee First Name', 
         e.position "Employee Title",
         i.employee_id "Invoice Employee ID",
         i.invoice_id 'Invoice',
         i. transaction_moment "Transaction moment"
	FROM
         employee AS e
	JOIN
         invoice AS i
         -- USING (employee_id) 
	ON
         e.employee_id = i.employee_id 
	ORDER BY 
			i. transaction_moment; 
            
           /* Exs 5.5. Отримати інформацію з таблиць employee, invoice про співробітників та дату транзакції.
Змінити попередній запит, добавивши в вибірку інформацію про продажі*/
          
          
SELECT 
	e.employee_id "Employee ID", 
	e.last_name "Employee Last Name", 
	e.first_name 'Employee First Name', 
	e.position 'Employee Title', 
	i.employee_id "Invoice Employee ID", 
	i.invoice_id 'Invoice', 
	i. transaction_moment "Transaction moment "
FROM
	employee AS e 
NATURAL JOIN 
	invoice AS i 
ORDER BY 
	i. transaction_moment;
       
       
       /*Exs/ 5.6.: Отримати інформацію з таблиць employee, invoice, customer про продажі.
Змінити попередній запит, добавивши в вибірку інформацію про клієнтів*/

SELECT 
e.employee_id "Employee ID",
e.last_name "Employee Last Name", 
e.first_name 'Employee First Name', 
e.position 'Employee Title', 
i.employee_id "Invoice Employee ID", 
i.invoice_id 'Invoice', 
i.customer_id 'Invoice Customer ID', 
i. transaction_moment 'Transaction moment', 
c.customer_id 'Customer ID', 
c.last_name 'Customer Last Name', 
c.first_name 'Customer First Name' 
From
employee AS e 
NATURAL JOIN 
invoice AS i 
JOIN 
customer AS c 
USING (customer_id) 
ORDER BY
e.last_name;

/*Exs 5.7.: : Отримати інформацію з таблиць employee, invoice, customer про продажі.
Змінити попередній запит так щоб вивести інформацію
про продажі в яких відсутня авторизація клієнтів.*/

SELECT e.employee_id "Employee ID", 
	e.last_name "Employee Last Name", 
	e.first_name 'Employee First Name', 
	e.position 'Employee Title', 
	i.invoice_id 'Invoice', 
	i.customer_id 'Invoice Customer ID',
	i. transaction_moment 'Transaction moment', 
	c.customer_id 'Customer ID', 
	c.last_name 'Customer Last Name',
	c.first_name 'Customer First Name' 
 FROM employee AS e 
 NATURAL JOIN 
	invoice AS i 
 LEFT JOIN 
	customer AS c
 USING (customer_id) 
 WHERE 
	customer_id IS NULL 
 ORDER BY 
	i. transaction_moment;
    
    /*Exs 5.8.: : Отримати інформацію з таблиць employee, department.
Створити запит який містить розгорнуту інформацію про всіх працівників та
департаменти.*/


SELECT 
e.employee_id 'Employee id',
 e.last_name 'Employee Last Name', 
 e.first_name 'Employee First Name', 
 e.position 'Employee position',
 e.manager_id 'Employee Manager Id',
 e.department_id 'Employee department_id', 
-- Manager as m
 m.employee_id 'Manager ID', 
 m.last_name "Manager Last Name", 
 m.first_name 'Manager First Name', 
 m.position 'Manager position', 
 m.department_id 'Manager Department Id', 
 d.department_id 'Department 10', 
 d.department_name 'Department Name', 
 d.city 'Department City'
 FROM
 department  as d
 RIGHT JOIN
 empoyee as e
 ON 
 e.department_id = d.department_id 
 RIGHT JOIN
 empoyee as m
 ON 
 e.manager_id = m.manager_id; -- ****
 
 /* Exs 5.9 Проаналізувати штат працівників компанії та та вивести інформацію 
 про осіб, які можуть / не можуть консультувати*/
 
 SELECT 
	 employee_id, 
	 first_name, 
	 last_name, 
	 position, 
	'Consulting' as Responsibility 
FROM
	employee 
where
position LIKE '%Consultant% '
UNION 
SELECT 
	 employee_id, 
	 first_name, 
	 last_name, 
	 position, 'Not Consulting'
FROM 
     employee
WHERE
     position NOT LIKE "%Consulting%"
 ORDER BY last_name;
 
 
 -- HW
 /* 5.1. Відобразити список усіх замовлених найменувань товарів разом з іменами та прізвищами клієнтів і моментом
проведення транзакції по інвойсу. Будь ласка, відсортуйте дані за ідентифікатором замовлення Orders ID.
Застосувати різні методи запитів з кількох таблиць. 
Перелік полів: (
orders.orders_id AS 'Orders ID',
product.product_name AS 'Product name',
product.category AS 'Product category',
invoice.invoice_id AS 'Invoice ID',
invoice.transaction_moment AS 'Transaction moment',
customer.last_name AS 'Customer lastname',
customer.first_name AS 'Customer first name’)
 */
 USE company;
SELECT 
orders.orders_id AS 'Orders ID',
	product.product_name AS 'Product name',
	product.category AS 'Product category',
		invoice.invoice_id AS 'Invoice ID',
		invoice.transaction_moment AS 'Transaction moment',
			customer.last_name AS 'Customer lastname',
			customer.first_name AS 'Customer first name'
FROM 
orders 
JOIN 
invoice ON orders.invoice_id = invoice.invoice_id
JOIN 
product ON orders.product_id = product.product_id
JOIN
customer ON invoice.customer_id = customer.customer_id
ORDER BY 
orders.orders_id;
 
 /* Exs 5.2. Відобразити імена співробітників, які працюють у відділі "Меркурій", і список всіх товарів,
 замовлених з '2023-07-01' по '2023-10-01’. Будь ласка, відсортуйте дані за ідентифікатором замовлення Orders ID. Перелік полів:
(
orders.orders_id AS 'Orders ID', 
product.product_name AS 'Product name',
product.category AS 'Product category',
invoice.invoice_id AS 'Invoice ID',
invoice.transaction_moment AS 'Transaction moment',
customer.last_name AS 'Customer last name', 
customer.first_name AS 'Customer first name’
) */
 SELECT
	orders.orders_id AS 'Orders ID',
		product.product_name AS 'Product name',
		product.category AS 'Product category',
			invoice.invoice_id AS 'Invoice ID',
			invoice.transaction_moment AS 'Transaction moment',
				customer.last_name AS 'Customer last name',
				customer.first_name AS 'Customer first name',
employee.last_name  'Employee last name', 
employee.first_name 'Employee name'
FROM     	
	orders
JOIN     	
	invoice ON orders.invoice_id = invoice.invoice_id
JOIN
	product ON orders.product_id = product.product_id
JOIN
   	customer ON invoice.customer_id = customer.customer_id
JOIN  
  	employee ON invoice.employee_id = employee.employee_id
JOIN  
  	department ON employee.department_id = department.department_id
WHERE 	 
	invoice.transaction_moment BETWEEN '2023-07-01' AND '2023-10-01'
	AND department.department_name = 'Mercury'
ORDER BY     orders.orders_id;


/* Exs 5.3.
Показати імена та прізвища всіх клієнтів з таблиці клієнтів, а також клієнтів без замовлень і замовлень без клієнтів
(якщо такі є). Будь ласка, відсортуйте дані за ID інвойсу.
Перелік полів: (
c.customer_id AS 'Customer ID',
c.last_name AS 'Last Name', 
c.first_name AS 'First Name', 
i.invoice_id AS 'Invoice ID', 
i.transaction_moment AS 'Transaction Moment'
)
*/

SELECT
	 c.customer_id AS 'Customer ID',    
	 c.last_name AS 'Last Name',    
	c.first_name AS 'First Name',   
	 i.invoice_id AS 'Invoice ID',    
	 i.transaction_moment AS 'Transaction Moment'
FROM 
    customer c
LEFT JOIN 
    invoice i ON c.customer_id = i.customer_id
UNION
SELECT 
    c.customer_id AS 'Customer ID',
    c.last_name AS 'Last Name',
    c.first_name AS 'First Name',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction Moment'
FROM 
    invoice i
LEFT JOIN 
    customer c ON c.customer_id = i.customer_id
ORDER BY 
    `Invoice ID`;