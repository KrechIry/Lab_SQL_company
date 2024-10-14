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

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk6` FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk7` FOREIGN KEY (`manager_id`) REFERENCES `employee`(`employee_id`);


ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk3` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);
