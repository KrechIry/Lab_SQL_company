CREATE DATABASE company;
USE company;
CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int NOT NULL,
	`user_name` varchar(255) NOT NULL DEFAULT '30',
	`first_name` varchar(255) NOT NULL DEFAULT '30',
	`last_name` varchar(255) NOT NULL DEFAULT '30',
	`position` varchar(255) NOT NULL DEFAULT '15',
	`employment_date` date NOT NULL,
	`department_id` int,
	`manager_id` int,
	`rate` float NOT NULL,
	`bonus` float,
	`address` varchar(255) NOT NULL DEFAULT '100',
	`phone_number` varchar(255) NOT NULL DEFAULT '15',
	`email` varchar(255) NOT NULL DEFAULT '50',
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `department` (
	`department_id` int NOT NULL,
	`department_name` varchar(255) NOT NULL DEFAULT '30',
	`status` varchar(255) NOT NULL DEFAULT '10',
	`city` varchar(255) NOT NULL DEFAULT '30',
	`street` varchar(255) NOT NULL DEFAULT '40',
	`building_no` int NOT NULL DEFAULT '3',
	`manager_id` int NOT NULL,
	`description` varchar(255) NOT NULL DEFAULT '150',
	PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
	`customer_id` int AUTO_INCREMENT NOT NULL,
	`last_name` varchar(255) NOT NULL DEFAULT '30',
	`gender` varchar(255) NOT NULL DEFAULT '1',
	`birth_date` date NOT NULL,
	`phone_number` int NOT NULL DEFAULT '12',
	`email` varchar(255) NOT NULL DEFAULT '50',
	`discount` int NOT NULL DEFAULT '2',
	`first_name` varchar(255) NOT NULL DEFAULT '30',
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `orders` (
	`orders_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`employee_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`product_id` int NOT NULL,
	`transaction_type` int NOT NULL,
	`transaction_moment` datetime NOT NULL,
	`amount` int NOT NULL,
	`status` varchar(255) NOT NULL DEFAULT '15',
	`payment_method` varchar(255) NOT NULL DEFAULT '15',
	`order_date` date NOT NULL,
	PRIMARY KEY (`orders_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
	`product_id` int NOT NULL,
	`product_name` varchar(255) NOT NULL DEFAULT '40',
	`category` varchar(255) NOT NULL DEFAULT '15',
	`manufacture` varchar(255) NOT NULL DEFAULT '30',
	`product_type` varchar(255) NOT NULL DEFAULT '15',
	`amount` int NOT NULL,
	`price` float NOT NULL,
	`product_description` varchar(255) NOT NULL DEFAULT '150',
	PRIMARY KEY (`product_id`)
);
CREATE TABLE `invoice` (
 `invoice_id` bigint(15) NOT NULL,
 `employee_id` INT NOT NULL, 
 `customer_id` INT, 
 `payment_method` INT NOT NULL, 
 `transaction_moment` DATETIME NOT NULL, 
 `status` varchar(10) NOT NULL 
--  PRIMARY KEY (`invoice_id`)
);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk6` FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk7` FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk3` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);
ALTER TABLE `invoice` ADD CONSTRAINT `invoice_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);
ALTER TABLE `invoice` ADD CONSTRAINT `invoice_fk2` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

-- drop column
alter table `orders`
drop column `transaction_type`;

alter table `orders`
drop column `transaction_moment`;

alter table `orders`
drop column `amount`;
alter table `invoice` add constraint `invoice_fk` foreign key (`invoice_id`);
-- add column
ALTER TABLE `orders`
ADD `invoice_id` bigint(15) NOT NULL;

ALTER TABLE `orders`
ADD `order_datetime` DATETIME NOT NULL;

ALTER TABLE `orders`
ADD `quantity` int NOT NULL;

-- 7.ALTER TABLE  -  MODIFY COLUMN
ALTER TABLE
	customer
MODIFY 
	phone_number BIGINT (15) NOT NULL;

ALTER TABLE
	employee
MODIFY
	position varchar(30) NOT NULL;
   
   -- 8.NOT NULL
ALTER TABLE 
    department
modify 
street varchar(50) NOT NULL;

ALTER TABLE 
    department
modify 
building_no INT(4);

-- 9.PRIMARY KEY
ALTER TABLE 
	invoice
ADD PRIMARY KEY (invoice_id);
/*
ALTER TABLE invoice
ADD CONSTRAINT invoice_id
PRIMARY KEY (column1_name, column2_name);*/

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk4` FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`);

ALTER TABLE orders
drop foreign key orders_fk2;

-- Removing unnecessary attributes from the 'department' table
ALTER TABLE department
DROP COLUMN description,
DROP COLUMN manager_id;

-- Removing unnecessary attributes from the 'employee' table
ALTER TABLE employee
DROP COLUMN address;

-- Removing unnecessary attributes from the 'orders' table
ALTER TABLE orders
DROP COLUMN order_date,
DROP COLUMN payment_method,
DROP COLUMN transaction_type,
DROP COLUMN transaction_moment;

alter table orders
add column invoice_id bigint(15) NOT NULL;


ALTER TABLE orders
drop foreign key orders_fk1;

ALTER TABLE `orders` ADD CONSTRAINT `invoice_fk3` FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`);
    
    ALTER TABLE orders
DROP COLUMN order_date,
 DROP COLUMN status,
DROP COLUMN payment_method,
DROP COLUMN employee_id,
DROP COLUMN customer_id;

-- 10. 
ALTER table
department
	ALTER city
    set default 'Lviv';
    
    ALTER TABLE 
    employee
    ADD UNIQUE (user_name);
    
    -- №2. -  Department Table
ALTER TABLE department
MODIFY department_id INT UNIQUE,
MODIFY department_name VARCHAR(255) UNIQUE;
-- MODIFY manager_id INT DEFAULT NULL;

-- Employee Table
ALTER TABLE employee
MODIFY employee_id INT UNIQUE,
MODIFY user_name VARCHAR(255) UNIQUE,
MODIFY bonus FLOAT DEFAULT 0;

ALTER TABLE invoice
MODIFY invoice_id BIGINT(15) UNIQUE;

ALTER TABLE 
	orders
MODIFY 
	orders_id INT UNIQUE;

-- Customer Table
ALTER TABLE customer
MODIFY customer_id INT UNIQUE,
MODIFY email VARCHAR(255) UNIQUE;

-- Product Table
ALTER TABLE product
MODIFY product_id INT UNIQUE,
MODIFY product_name VARCHAR(255) UNIQUE,
MODIFY price FLOAT DEFAULT 0;

ALTER TABLE department
DROP COLUMN status;

