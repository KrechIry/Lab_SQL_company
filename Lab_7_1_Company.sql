/* 7.1 Визначити найбільшу та середню заробітню плату в компанії. 
Вивести ім’я та прізвище працівників, які отримують найбільшу заробітну плату. 
Показати ім’я та прізвище працівників, чия заробітна плата більша за середню по компанії.
(Для реалізації поставленої задачі застосуємо Simple Subquery WHERE)
*/
use company;

SELECT
	first_name,
	last_name,
    rate
FROM
	employee
    WHERE
    rate < (
    SELECT
     MAX(rate) AS 'Biggest Rate'
    -- AVG(rate) AS 'Average Rate'
    FROM
     employee);
     
     /*7.2. Бізнес потреба: Вивести дані про менеджерів, що не працюють в Львові. 
Для реалізації поставленої задачі використаємо Simple Subquery IN, NOT IN:
Вивести ім’я, прізвище та department_id працівників. 
Відсортуйте, будь ласка, за іменем працівника. 
*/
SELECT
	first_name,
	last_name,
    position,
    department_id
FROM
	employee
WHERE
	department_id NOT IN (1,3)
AND
	position LIKE 'Manager%'
ORDER BY 
	first_name;	
-- -- -- -- -- -- --
SELECT
	first_name,
	last_name,
    position,
    department_id
    -- city
FROM
	employee e
WHERE
	e.department_id IN 
 --   e.department_id NOT IN 
    (
    SELECT
		department_id
    FROM
		department d 
	WHERE
    -- city = "Lviv"
    city NOT IN ('Lviv')
    )
AND
	position LIKE 'Manager%'
ORDER BY 
	first_name;	
    
   /*7.3. Бізнес потреба: Вивести дані про працівників, що вказані в інвойсі. 
Для реалізації поставленої задачі використаємо Simple Subquery IN, NOT IN:
Вивести employee_id,  ім’я, прізвище та посаду працівників. ( значення мають бути унікальними) */

SELECT
	employee_id
	first_name,
	last_name,
    position
FROM
	employee
WHERE
	employee_id IN 
    (
    SELECT DISTINCT
    employee_id
    FROM
    invoice    );
    
    /*7.4. Бізнес потреба: Вивести дані про працівників, що вказані в інвойсі.
Вивести назви відділів у містах разом з іменами та прізвищами усіх менеджерів, що працюють у Львові.
Перелік полів: 
Ім’я;
Прізвище;
Посада;
Ідентифікатор відділу;
Назва відділу;
Назва міста.*/

SELECT
	first_name,
	last_name,
    position,
    d.department_id,
    d.department_name,
    city
FROM
	(SELECT
		first_name,
		last_name,
		position,
		department_id
    FROM
		employee
	WHERE
    position LIKE 'Manager%'
    ) AS managers
    JOIN 
    department AS d
ON 
    d.department_id = managers.department_id -- помилка managers.department
    WHERE
    city = 'Lviv';
    
    /* 7.5. Бізнес потреба: Проаналізувати структуру компанії та вивести інформацію про кількість працівників в кожному з відділень.  
Перелічіть назви міст, в яких розташовані відділення, а також кількість працівників у кожному з них.
Перелік полів: 
Назва відділення;
Ідентифікатор відділенні;
Назва міста;
Кількість працівників у відділенні;*/

SELECT
	department_id,
    department_name,
    city,
(
SELECT COUNT(*)
FROM
employee
WHERE
department_id = department.department_id
) AS 'Count of Employee'
FROM
department;

/*7.6. Бізнес потреба: Проаналізувати структуру компанії та вивести інформацію про відділи з числом працівників більше 5.
Виведіть назви міст, у яких розташовані відділення, а також кількість працівників у кожному відділенні з числом працівників більше 5. 
Перелік полів: 
Назва відділення;
Ідентифікатор відділенні;
Назва міста;
Кількість працівників у відділенні;
*/
SELECT
	department_id,
    department_name,
    city,
(
SELECT COUNT(*)
FROM
employee
WHERE
department_id = department.department_id
) AS 'Count of Employee'
FROM
department
GROUP BY
 department_id
HAVING
(
SELECT COUNT(*)
FROM
employee
WHERE
department_id = department.department_id) > 5;

/*7.7. Бізнес потреба: Вивести інформацію про кількість продукту. 
Виведіть назву продукту з найменшою кількістю
Перелік полів: 
Ідентифікатор рахунку;
Назва продукту;
Категорія продукту;
Дата та час замовлення; 
Кількість продукту.
Відсортуйте, будь ласка, за такими полями: orders.quantity, orders.product_id
*/
SELECT 
invoice_id,
product_name,
category,
order_datetime,
quantity
FROM 
orders, product
WHERE
(orders.product_id, quantity) IN
(
SELECT product_id, MAX(quantity) 
FROM orders
GROUP BY orders.product_id
HAVING
MAX(quantity) <
				( SELECT
                AVG (quantity)
                FROM
                orders)                
)
AND orders.product_id = product.product_id
ORDER BY
	orders.quantity, orders.product_id;

/*7.8. Бізнес потреба: Проаналізувати структуру компанії та вивести інформацію про співробітників. 
Перерахуйте співробітників, що мають підлеглих
*/
SELECT
	employee_id,
	first_name,
	last_name,
    position,
    manager_id
FROM
	employee
    WHERE exists (
    SELECT
		employee_id
		FROM
        employee
        WHERE
        manager_id=employee.employee_id
);

/*7.9. Бізнес потреба: Проаналізувати структуру компанії та вивести інформацію про відділи без працівників. 
Знайдіть відділи, в яких досі немає працівників, використовуючи функцію NOT EXISTS.
*/
SELECT
	department_id,
    department_name
    FROM
    department 	AS d
    WHERE NOT EXISTS
    (
    SELECT *
    FROM 
		employee
	WHERE
    department_id=d.department_id
    );


-- HW
/* 7.1
*/

SELECT
	AVG(e.rate) AS 'Average Rate',
    MAX(e.rate) AS 'Biggest Rate'
FROM
	employee as e
WHERE
	department_id NOT IN (1,3)
AND
	position LIKE 'Manager%'
ORDER BY 
	first_name;	
    
    -- -- --
SELECT
	AVG(e.rate) AS 'Average Rate',
    MAX(e.rate) AS 'Biggest Rate'
FROM
	employee as e
WHERE
	e.department_id IN 
 --   e.department_id NOT IN 
    (
    SELECT
		department_id
    FROM
		department d 
	WHERE
    -- city = "Lviv"
    city NOT IN ('Lviv')
    )
AND
	position LIKE 'Manager%'
ORDER BY 
	first_name;	 
    
    
    /*7.2*/
    
    SELECT 
    d.department_name,
    e.position
FROM 
    department d
JOIN 
    employee e ON d.department_id = e.department_id
GROUP BY 
    d.department_name, e.position
HAVING 
    AVG(e.rate) < (
        SELECT 
            AVG(e1.rate)
        FROM 
            employee e1
        WHERE 
            e1.position = e.position
    );


-- --
SELECT 
    d.department_name,
    e.position,
    AVG(e.rate) AS 'Less Rate'
FROM 
    employee AS e
JOIN 
    department as d ON e.department_id = d.department_id
GROUP BY 
    d.department_name, e.position
HAVING 
    AVG(e.rate) < (
        SELECT 
            AVG(e1.rate)
        FROM 
            employee e1
        WHERE 
            e1.position = e.position
    );
