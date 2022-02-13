CREATE SCHEMA IF NOT EXISTS homes_for_heroes;

USE homes_for_heroes;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS admin_users;
CREATE TABLE IF NOT EXISTS admin_users (
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    admin_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (admin_id)
);

DROP TABLE IF EXISTS client_users;
CREATE TABLE IF NOT EXISTS client_users (
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    verified BOOLEAN NOT NULL,
    verification_code VARCHAR(32) UNIQUE,
    alert_case_id INT UNIQUE,
    user_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (user_id),
    FOREIGN KEY (alert_case_id)
    REFERENCES cases(case_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

DROP TABLE IF EXISTS cases;
CREATE TABLE IF NOT EXISTS cases (
    user_id INT NOT NULL,
    admin_id INT NOT NULL,
    notes TEXT,
    last_update DATETIME NOT NULL DEFAULT NOW(),
    case_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (case_id),
    FOREIGN KEY (user_id)
	REFERENCES client_users (user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (admin_id)
	REFERENCES admin_users (admin_id)
        ON UPDATE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;