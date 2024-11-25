use company;

/*  6.1: Вивести інформацію про ідентифікатор співробітника, повне ім’я та email співробітника .
Деталі: Отримати інформацію з таблиці employee про співробітників та згенерувати електронну пошту працівника.*/ 
SELECT 
LPAD(employee_id, 5, '0') as 'Employee ID', 
CONCAT(" "last_name, first_name) as 'Full name', 
 CONCAT(" ", last_name, first_name, position) as 'Full name with Position', 
CONCAT(LOWER(first_name),".", LOWER (last_name), "@company.com") as 'email' 
FROM  employee;

/*6.2: Відобразити інформацію про працівника, дату його найму та стаж роботи.
Деталі: Отримати інформацію з таблиці employee про співробітників та про стаж роботи кожного працівника*/
SELECT 
first_name 'First name', 
last_name 'Last name', 
		DATE_FORMAT(employment_date, "%d %M %Y") AS 'Date of hiring', 
		FORMAT (DATEDIFF(CURDATE(), employment_date)/365.22,1) 'Length of service', 
		TIMESTAMPDIFF (YEAR, employment_date, CURDATE()) AS 'Years of service' 
FROM employee;

/* 6.3: Відобразити інформацію про зарплати та премії співробітників(два окремих звіти).
Деталі: Отримати інформацію з таблиці employee: 1) Визначити найвищу та найнижчу зарплату в компанії. 2) Визначити середню премію
для співробітників, які отримують премію. 3) Визначити середнєзначення премії для всієї компанії. */
SELECT 
'Count of All employees' 
	AS 'Bonus eligible', 
	COUNT(*) 'Count of employees' 
FROM employee 
 UNION 
 SELECT 
 'Count of employees who received bonus'
 AS 'Bonus eligible', 
 COUNT(*) 'Count of employees' 
 FROM employee 
 WHERE bonus IS NOT NULL;
 
 SELECT 
	MIN(rate) 'Lowest salary', MAX(rate) 'Highest salary', 
	FORMAT (AVG(bonus),2) 
		AS 'Average Bonus by Employee', 
	FORMAT (SUM(bonus) / COUNT(*),2) 
		AS "Average Bonus by Company"
 FROM employee;
 
 /*6.4: Відобразити інформацію про список посад співробітників за відділами та представництвами.
Деталі: Отримати інформацію з таблиць department, employee : 1) Визначити кількість відділів компанії. 2) Визначити кількість міст, в
яких компанія має представництва. 3. Визначити кількість менеджерів, продавців і т.д. 4. Показати кількість працівників у кожному
відділі. 5. З'ясувати, скільки менеджерів, продавців і т.д. є в кожному відділі.*/

SELECT
 COUNT(*) AS 'Count of Offices',
 COUNT (DISTINCT city) 
 AS 'Count of representative offices of cities'
 FROM department;
 
 SELECT position As 'Position', COUNT(*) AS
 'Count Employee by Position'
 FROM employee
 GROUP BY position;
 
 SELECT department_id AS 'Department id',
 COUNT(*) AS
 'Count of employees by Department'
 FROM employee
 GROUP BY department_id;
 
 SELECT
 department_id AS 'Department id',
 position As 'Position', 
 COUNT(*) AS 
 'Count of employees by Position for each Departmenn' 
 FROM employee 
 GROUP BY department_id, position 
 ORDER BY COUNT(*) DESC;
 
 
 /*6.5: Відобразити інформацію про список посад співробітників за відділами та представництвами.
Деталі: Відобразити інформацію про список посад співробітників відділу продажів по відділах. */
 SELECT
 department_id, position, 
 COUNT(*) AS 'Count Employee' 
 FROM employee 
 GROUP BY department_id, position 
 HAVING COUNT(*) > 1;
 
 /*6.5: Відобразити інформацію про список посад співробітників за відділами та представництвами.
Деталі: Відобразити інформацію про список посад співробітників відділу продажів по відділах.
Вивести назву відділів і посад, в яких працює лише один співробітник зі Львова*/

SELECT
	d.department_name,
	position,
	COUNT(*) 'Count Employee by Position'
FROM
	employee e
JOIN
	department d
ON
	e.department_id = d.department_id
WHERE
	city ='LVIV'
GROUP BY
	position, department_id
HAVING
	COUNT(*) = 1
ORDER BY 
	d.department_name;
    
    /* 6.5: Відобразити інформацію про список посад співробітників за відділами та представництвами.
Деталі: Відобразити інформацію про список посад співробітників відділу продажів по відділах. Вивести список відділів, співробітників та їх
посад, які здійснили більше 10 продажів. */

SELECT
	d.department_name,
	last_name,
    first_name,
    position,
	COUNT(invoice_id) 'Employee by Sales'
FROM
	department d 
JOIN
	employee e
ON
	 d.department_id=e.department_id
JOIN
invoice i
ON
e.employee_id = i.employee_id 
GROUP BY i.employee_id 
HAVING COUNT(invoice_id) > 10 
ORDER BY COUNT(invoice_id) DESC;

-- HW
/* 1. Відобразити інформацію про товари (ідентифікатор товару, назву товару, категорію). 
Перелік полів: Ідентифікатор "Product ID" повинен формуватися з ідентифікатора співробітника з додаванням "0" довжиною 4 символи. (помилка в умові?)
Назва товару як "Назва товару" повинна містити назву виробника, не містити номер моделі (без крапки після "/" в полі product_name), 
формат: [виробник] :: [назва_продукту]. 
Категорія в полі "Категорія" повинна мати формат:
[тип_продукту] - [категорія] у верхньому регістрі. 
Будь ласка, відсортуйте дані за виробником. */
SELECT
LPAD(product_id, 4, '0') as 'Product ID', 
CONCAT(manufacture, " :: ",  product_name) as 'Product Name',
CONCAT(UPPER(product_type), " - ",  UPPER(category)) as 'Category'
FROM 
product
where 
	product_name not like "%/%"
ORDER BY manufacture;

/*6.2. Відобразити інформацію про пропродажі по місячно.
 Місяць "Month" повинен формуватися з місяця, в якому здійснювалися транзакції з додаванням "0" довжиною 2 символи. 
 Загальна виручка as 'Total revenue' повинна містити загальну суму продажей за кожен місяць. 
 Квартал продажів as 'Sales Period' повинен містити порядковий номер кварталу в році і відповідний рік, 
 формат: 'Quater ' [квартал] - [рік]. Будь ласка, відсортуйте дані за датою продажу.*/

SELECT
LPAD(MONTH(invoice.transaction_moment), 2 , "0") AS 'Month', 
SUM(invoice.total_amount) AS 'Total revenue',
'Sales Period'
'Quater'

SELECT 
    LPAD(MONTH(invoice.transaction_moment), 2, '0') AS 'Month',
    SUM(orders.quantity * product.price) AS 'Total revenue',
    CONCAT('Quarter ', QUARTER(invoice.transaction_moment), ' - ', YEAR(invoice.transaction_moment)) AS 'Sales Period'
FROM 
    invoice
JOIN 
    orders ON orders.invoice_id = invoice.invoice_id
JOIN 
    product ON product.product_id = orders.product_id
GROUP BY 
    YEAR(invoice.transaction_moment), 
    MONTH(invoice.transaction_moment)
ORDER BY 
    invoice.transaction_moment;
