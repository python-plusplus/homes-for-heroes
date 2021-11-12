CREATE SCHEMA IF NOT EXISTS homes_for_heroes;

USE homes_for_heroes;

DROP TABLE IF EXISTS admin_users;
CREATE TABLE IF NOT EXISTS admin_users (
name VARCHAR(255) NOT NULL UNIQUE,
email VARCHAR(255) NOT NULL UNIQUE,
phone VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
admin_id int NOT NULL AUTO_INCREMENT,
primary key (admin_id)
);

DROP TABLE IF EXISTS client_users;
CREATE TABLE IF NOT EXISTS client_users (
name VARCHAR(255) NOT NULL UNIQUE,
email VARCHAR(255) NOT NULL UNIQUE,
phone VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
client_id int NOT NULL AUTO_INCREMENT,
primary key (client_id)
);

DROP TABLE IF EXISTS cases;
CREATE TABLE IF NOT EXISTS cases (
client_id int NOT NULL UNIQUE,
admin_id int NOT NULL UNIQUE,
notes VARCHAR(255),
last_update DATETIME,
CONSTRAINT FOREIGN KEY (client_id) REFERENCES client_users(client_id),
CONSTRAINT FOREIGN KEY (admin_id) REFERENCES admin_users(admin_id)
);
