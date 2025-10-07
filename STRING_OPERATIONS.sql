-- create database for practicong string operations -- 

CREATE DATABASE string_operation;
USE string_operation;

-- creating table --

CREATE TABLE user_profiles (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    city VARCHAR(50),
    bio TEXT
);

INSERT INTO user_profiles (full_name, email, phone_number, city, bio) VALUES
('  Alice Johnson  ', 'ALICE.JOHNSON@EXAMPLE.COM', ' 123-456-7890 ', 'new york', 'Loves music and hiking.'),
('Bob Smith', 'bob.smith@example.com', '987-654-3210', 'Los Angeles', '  Enjoys coding and coffee.  '),
('charlie brown', 'charlie.b@example.com', '555-555-5555', 'chicago', 'Fan of jazz and books'),
('Diana Prince', 'DIANA.PRINCE@EXAMPLE.COM', '444-444-4444', 'Metropolis', '  superhero and strategist  '),
('Eve', 'eve@example.com', '333-333-3333', 'Gotham', 'Tech geek & gamer');

-- checking data --

SELECT *
FROM user_profiles;

-- Basic String Manipulation QUETIONS --

SELECT 
    UPPER(full_name) AS Names
FROM
    user_profiles;

-- 2.	Convert all city names to proper case (first letter uppercase, rest lowercase). --

UPDATE user_profiles 
SET 
    city = CONCAT(UCASE(LEFT(TRIM(city), 1)),
            LCASE(SUBSTRING(TRIM(city), 2)));

-- 3.	Trim leading and trailing spaces from full_name --

SELECT 
    TRIM(full_name)
FROM
    user_profiles;

UPDATE user_profiles 
SET 
    full_name = TRIM(full_name);

-- 4.	Trim spaces from phone_number. --

SELECT 
    TRIM(phone_number)
FROM
    user_profiles;

-- 5.	Count the number of characters in each bio. --

SELECT 
    full_name, LENGTH(bio)
FROM
    user_profiles;

						-- ️ Substring Extraction Questions --

SELECT 
    SUBSTRING_INDEX(full_name, ' ', 1) AS FIRST_NAME
FROM
    user_profiles ;   -- full_name is not trimed So Alice Will not be shown == / updated now it will work

SELECT 
    TRIM(SUBSTRING_INDEX(full_name, ' ', - 1))
FROM
    user_profiles;

-- 3. Get the first 5 characters of each city. --

SELECT
    city, LEFT(TRIM(city), 5) AS city_prefix
FROM
    user_profiles;

-- 4.	Extract the domain name from each email --

SELECT 
    email, SUBSTRING_INDEX(email, '@', - 1) AS domain
FROM
    user_profiles;

-- 5.	Extract the area code (first 3 digits) from phone_number. --

SELECT 
    phone_number, LEFT(TRIM(phone_number), 3) AS area_code
FROM
    user_profiles;

							-- Concatenation & Formatting Questions --

-- 1.	Create a new column display_name as full_name from city. --

-- Creating new column --

ALTER TABLE user_profiles
ADD COLUMN display_name VARCHAR(50);

-- COMBINE full_name with city

UPDATE user_profiles 
SET 
    display_name = CONCAT(full_name, '-', TRIM(city));
 
-- 2.	Format a new email as firstname.lastname@stringop.com. --

-- create new column for new email ---

ALTER TABLE user_profiles
	ADD COLUMN new_email VARCHAR(150),
	ADD COLUMN fist_name VARCHAR(100),
	ADD COLUMN last_name VARCHAR(100);
 
 -- ADDING values in fist _name and last-name --
 
UPDATE user_profiles 
SET 
    fist_name = SUBSTRING_INDEX(full_name, ' ', 1);
 
UPDATE user_profiles 
SET 
    last_name = SUBSTRING_INDEX(full_name, ' ', - 1);

-- creating new_email--

UPDATE user_profiles 
SET 
    new_email = CONCAT(fist_name,
            '.',
            last_name,
            SUBSTRING_INDEX(email, '@', - 1));

-- 3.	Create a username column from full_name in lowercase with a dot separator. --

ALTER TABLE user_profiles
ADD COLUMN username VARCHAR(60);

	UPDATE user_profiles 
SET 
    username = LOWER(CONCAT(SUBSTRING_INDEX(full_name, ' ', 1),
                    '.',
                    SUBSTRING_INDEX(full_name, ' ', - 1)));

ALTER TABLE user_profiles
CHANGE COLUMN fist_name first_nam VARCHAR(50);

-- 4.	Concatenate city and phone_number with a hyphen.--

SELECT 
    full_name,
    CONCAT(TRIM(city), '-', TRIM(phone_number)) AS cust_info
FROM
    user_profiles;

-- 5.	Build a search_key column as full_name - email. --

ALTER TABLE user_profiles
ADD COLUMN  search_key VARCHAR(150);
	UPDATE user_profiles 
SET 
    search_key = CONCAT(full_name, '-', TRIM(email));

							-- Pattern Matching Questions --

-- 1.	Find users whose bio contains the word "music".

SELECT 
    *
FROM
    user_profiles
WHERE
    BIO LIKE '%music%';

-- 2.	Select users where full_name starts with "D". --

SELECT 
    *
FROM
    user_profiles
WHERE
    full_name LIKE 'D%';

-- 3.	Find users whose email ends with ".com". --

SELECT 
    *
FROM
    user_profiles
WHERE
    email LIKE '%.com'
        AND email NOT LIKE '%.com%';

-- 4.	Retrieve rows where bio contains "&". --

SELECT *
	FROM user_profiles
	WHERE bio LIKE '%&%';

-- 5.	Select users whose city contains the letter "o". --

SELECT *
	FROM user_profiles
	WHERE city LIKE '%o%';

							-- Data Cleaning Questions --

-- 1 Replace all dashes in phone_number with empty strings.

UPDATE user_profiles
SET phone_number = REPLACE(phone_number,'-','');

-- 2.	Replace "&" with "and" in bio. --

UPDATE user_profiles
	SET bio = REPLACE(
    bio,'&','and'
);

-- 3.	Remove extra spaces from bio. --

UPDATE user_profiles
SET bio = TRIM(bio);

-- 4.Standardize email to lowercase. --

UPDATE user_profiles
SET email = LOWER(email);

-- 5.	Capitalize only the first letter of each bio. --

UPDATE user_profiles
SET bio = CONCAT(
UPPER(LEFT(TRIM(bio),1)),
LOWER(SUBSTRING(TRIM(bio),2))
);

                          -- Advanced String Logic Questions --

-- 1.	Count how many spaces are in each bio. --

SELECT
bio,
LENGTH(bio)-LENGTH(REPLACE(bio,' ','')) AS space_count
FROM user_profiles;

-- 2.	Find the position of "@" in each email.

SELECT 
email,
LOCATE('@',email) AS at_position
FROM user_profiles;

-- 3.	Extract the middle name from full_name if present.

SELECT 
	full_name,
CASE
	WHEN LENGTH(full_name)- LENGTH(REPLACE(full_name,' ','')) >= 2
THEN
	SUBSTRING_INDEX(SUBSTRING_INDEX(full_name,' ',2),' ',-1)
ELSE NULL
	END AS middle_name
FROM user_profiles;

-- 4.	Flag rows where bio is longer than 30 characters. --

SELECT bio,
	CASE 
		WHEN LENGTH(bio) > 30 THEN 'long_bio'
	ELSE 'not_long'
END AS bio_char
	FROM user_profiles;















