CREATE DATABASE `linkedin`;

USE `linkedin`;

CREATE TABLE `users`(
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(32) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `schools`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL,
    `type` ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `location` VARCHAR(128) NOT NULL,
    `year` DATE,
    PRIMARY KEY(`id`)
);

CREATE TABLE `companies`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL,
    `industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` VARCHAR(128) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `userConnections`(
    `id` INT AUTO_INCREMENT,
    `user1_id` INT,
    `user2_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user1_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`user2_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `userSchoolConnections`(
    `id` INT AUTO_INCREMENT,
    `start` DATE,
    `end` DATE,
    `type_degree` VARCHAR(10),
    `user_id` INT,
    `school_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`)
);

CREATE TABLE `userCompanyConnections`(
    `id` INT AUTO_INCREMENT,
    `start` DATE,
    `end` DATE,
    `user_id` INT,
    `company_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);

