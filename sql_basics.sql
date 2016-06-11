#####################################################
# C.R.U.D.  #########################################
#####################################################

-- CREATE    |    INSERT
-- Read      |    SELECT
-- Update    |    UPDDATE
-- Delete    |    DELETE

--C.R.U.D. is an accronym for the four ways we work with data (in a CRUD app). Create, Read, Update, and Delete.

#####################################################
# ERRORS  ###########################################
#####################################################

--Troubleshoot errors at http://dev.mysql.com/doc + version

#####################################################
# SCHEMA/DATABASE ###################################
#####################################################
--SQL statements can affect both the data in and the schema of the database. 

--A database is a container that holds tables and data. A database keeps groups of tables separate from other groups of tables.

--The terms database and schema can sometimes be used interchangably, for example in the MySQL workbench when you click the icon to create a database it takes you to a "new schema" tab. 

CREATE SCHEMA movies_db_1;
-- Create a new database (schema)

CREATE SCHEMA IF NOT EXISTS movies_db_1;
-- Create a new database (schema) only if one does not already exist with the name movies_db_1. Without the "IF NOT EXISTS" condition CREATE SCHEMA would throw an error if movies_db_1 already existed and would stop the query statement, but if we use "IF NOT EXISTS" and movies_db_1 already exists the query statement gives a warning and continues with the next statement. Errors stop the query, warnings don't stop the query. 

CREATE DATABASE IF NOT EXISTS movies_db_2;
-- Similar to the CREATE SCHEMA query. Works the same way (exactly?)
-- Create a new database (schema) only if one does not already exists with the name movies_db_2.

DROP DATABASE `movies_db_2`;
-- Note the back ticks. Are they optional? It works without them in my testing. 
-- Deletes the database named movies_db_2.

#####################################################
# COLLATION  ########################################
#####################################################

CREATE SCHEMA movies_db_3 CHARACTER SET = utf8;
-- Create a database named movies_db_3 and set the character collation to utf8. 


#####################################################
# DROP SCHEMA/DATABASE  #############################
#####################################################

DROP DATABASE movie_db_3;
--Deletes all the tables and data in the database named movie_db_3, also destroys the database itself. 

DROP SCHEMA IF EXISTS movie_db_3;
--Same as above, uses SCHEMA instead of DATABASE (interchangeable) and uses the optional IF EXISTS keyword to throw a warning if the database does not exists instead of a warning that would stop the script. 


#####################################################
# CREATE TABLE  #####################################
#####################################################

CREATE TABLE actors (name VARCHAR(50));
-- Create a table called actors (in the active database) with a column named name that is a 

CREATE TABLE movies (title VARCHAR(200), year INTEGER);
-- Create a table called movies (in the active database) with two columns, the first named title which holds strings up to 200 characters long, the second named year which holds integers

CREATE TEMPORARY TABLE temptable (name VARCHAR(50));
-- Create a temporary table named temptable that holds 50 character strings. A temporary table only exists durring the current connection and it is automatically dropped once the connection is ended. 

CREATE TABLE actors (name VARCHAR(50) NOT NULL);
-- Create a table named actors that holds 50 char strings, and will not accept a NULL value. 

CREATE TABLE movies (title VARCHAR(200) NOT NULL, year INTEGER NULL);
-- Create a table called movies with two columns. First column title 200 char strings and doesn't accept NULL values. The second column is year and holds integers will accept a NULL value.

CREATE TABLE movies (title VARCHAR(200) NOT NULL, year INTEGER NULL) ENGINE InnoDB;
-- Same as above, but also specifies the ENGINE that will run the db/table.

CREATE TABLE genres (id INTEGER AUTO_INCREMENT PRIMARY KEY, name VARCHAR(30) UNIQUE KEY NOT NULL);
-- Create a table named genres with two columns. Id which is an integer and our primary key, and name which holds strings of up to 30 characters and is a unique key which can't be null.
-- The primary key is a special field which can't be null and can't be duplicated. We're using the AUTO_INCREMENT command to use the built in incrementation in SQL to give each entry a unique INTEGER for id.
-- Unique keys are special fields which can be null (except that we stated NOT NULL in this case) and which must be unique.

#####################################################
# RENAME TABLE  #####################################
#####################################################

RENAME TABLE movies TO movies_table;
RENAME TABLE actors TO actors_table;
--Stack two SQL statements to run the two commands one after the other. 
--Rename the table named movies (in the active database) to movies_table. Similarly, rename actors to actors_table.

RENAME TABLE movies TO movies_table, actors TO actor_table;
-- Same as above, expressed as a single statement.

#####################################################
# DROP TABLE  #######################################
#####################################################

DROP TABLE reviews;
--Drop the reviews table. Throws an error and stops the SQL script if reviews does not exist. Dropping a table destroys all the data in the table, and destroys the table itself.

DROP TABLE reviews IF EXISTS;
--Drop the reviews table. Throws a warning, but does not stop the SQL script if the the reviews table does not exist.

#####################################################
# TRUNCATE TABLE  ###################################
#####################################################

TRUNCATE TABLE reviews;
--Drops the table named reviews, destroying all the data inside the table and the table itself, and then automatically recreates a new, empty table named reviews. This command is similar in nature to DROP, but where DROP TABLE deletes the table, TRUNCATE TABLE is more like "drop data"

TRUNCATE reviews;
--Same as above, but less explicitly stated. 


#####################################################
# ALTER TABLE  ######################################
#####################################################

ALTER TABLE movie_table ADD COLUMN genre VARCHAR(100);
--Alter the structure of the table named movie_table to add a column named genre that holds strings of up to 100 characters.

ALTER TABLE actor_table ADD (pob VARCHAR(100), dob DATE);
--Alter the structure of the table named actor_table to add two columns (COLUMN is an optional command used to state what you're adding more explicitly). The first column is named pob (place of birth) which holds strings of up to 100 characters. The second column is named dob (date of birth) and holds a date type object.

ALTER TABLE actor_table CHANGE COLUMN pob place_of_birth VARCHAR(100);
--Alter the structure of the table named actor_table to rename the column named pob to place_of_birth which holds strings of up to 100 characters. 
--Unlike the ADD keyword the CHANGE keyword can only modify one column at a time. 

ALTER TABLE movie_table CHANGE year year_released YEAR;
--Alter the structure of the movie_table to rename the column year to year_released (to help avoid confusion with the keyword YEAR which is a DATE type). Note we did not explicitly state that we were changing a column with the COLUMN keyword.

ALTER TABLE actor_table DROP COLUMN date_of_birth;
--Alter the structure of actor_table to DROP the column (optional keyword) named date_of_birth;

ALTER TABLE movies ADD COLUMN id INTEGER AUTO_INCREMENT PRIMARY KEY FIRST;
-- Add a column named id to the movies table in the active database. The id column holds integers which auto-increment and which are the primary key in the table. The FIRST keyword makes the id column the first column in the table.

ALTER TABLE movies ADD COLUMN genre_id INTEGER NULL, ADD CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genres(id);
-- Adds a genre_id column to the movie table in the active database which holds integers which can be null, but which must be one of the values of a foreign key. We specificy the foreign key connection, but saying (genre_id) is a FOREIGN KEY which REFERENCES the id column in the genres table. 

ALTER TABLE movies 
ADD COLUMN genre_id INTEGER NULL, 
ADD CONSTRAINT FOREIGN KEY (genre_id) REFERENCES genres(id);
-- Same as above, but written in multi-line format.

#####################################################
# SHOW  #############################################
#####################################################

SHOW ENGINES;
-- Show the available engines, including the default engine

#####################################################
# USE  ##############################################
#####################################################

USE movies_db_1;
-- Move to/activate/point to/use the database named movies_db_1

#####################################################
# SELECT  ###########################################
#####################################################

SELECT * FROM movies;
-- Select everything from the table named movies

SELECT title, year FROM movies;
-- Select the colums title and year (in that order) from the table named movies

SELECT movies.title, movies.year FROM movies;
-- Same as above, just more verbose/exact
-- Select the colums title and year (in that order) from the table named movies

#####################################################
# WHERE  ############################################
#####################################################

SELECT * FROM movies WHERE year = 1999;
-- Select everything from the movies table where the year equals 1999

SELECT * FROM movies WHERE year != 1999;
-- Select everything from the movies table where the year does NOT equal 1999

SELECT * FROM movies WHERE year > 1999;
-- Select everything from the movies table where the year is greater than 1999

SELECT * FROM movies WHERE year >= 1999;
-- Select everything from the movies table where the year is greater than or equal to 1999

SELECT * FROM movies WHERE year < 1999;
-- Select everything from the movies table where the year is less than 1999

SELECT * FROM movies WHERE year <= 1999;
-- Select everything from the movies table where the year is less than or equal to 1999

SELECT * FROM movies WHERE year = 1999 AND title = "The Matrix";
-- Select everything from the movies table where the year is equal to 1999 and the title is equal to The Matrix

SELECT * FROM movies WHERE year = 1998 OR year = 2000;
-- Select everything from the movies table where the year is equal to 1998 or 2000

SELECT * FROM movies WHERE year BETWEEN 1998 AND 2000;
-- Select everything from the movies table where the year is between 1998 and 2000

SELECT * FROM movies WHERE title LIKE "godfather";
-- Select everything from the movies table where the title starts with the word godfather (didn't work because no strings in the title started with godfather)

SELECT * FROM movies WHERE title LIKE "%godfather";
-- Select everything from the movies table where the title contains the word godfather. The percent sign is a wildcard that allows the string to start with any character(s) before godfather (worked)

SELECT * FROM movies WHERE title LIKE "%godfather%";
-- Select everything from the movies table where the title contains the word godfather. The percent signs are wildcards that allows the string to start with any character(s) before godfather and end with any character(s) after godfather (worked) 
-- The LIKE clause can work with strings that are not case sensitive

#####################################################
# ORDER BY  #########################################
#####################################################

SELECT * FROM movies ORDER BY year;
-- Select everything from movies and order by the year in ascending order

SELECT * FROM movies ORDER BY year DESC;
-- Select everything from movies and order by the year in descending order

SELECT * FROM movies ORDER BY year ASC;
-- Select everything from movies and order by the year in ascending order (explicitly stated)

SELECT * FROM movies ORDER BY year ASC, title DESC;
-- Select everything from movies and order by the year in ascending order (explicitly stated), and then within each year in descending order by title

#####################################################
# LIMIT  ############################################
#####################################################

SELECT * FROM movies LIMIT 10;
-- Select everything from the movies table and show the first 10 results.

SELECT * FROM movies LIMIT 10 OFFSET 0;
-- Same as above but explicitly state the offset.
-- Select everything from the movies table and show the first 10 results (show results 0 - 9)

SELECT * FROM movies LIMIT 10 OFFSET 10;
-- Select everything from the movies table and show the second 10 results (show results 10 - 19)

SELECT * FROM movies LIMIT 10 OFFSET 20;
-- Select everything from the movies table and show the third set of 10 results (show results 20 - 29)

SELECT * FROM movies LIMIT 20, 10;
-- Same as above but written differently. The first number is the offset and the second number is the limit.
-- Select everything from the movies table and show the third set of 10 results (show results 20 - 29). 

--NOTE... some clients automatically add a limit to your query (of say 1000 results). If your dataset has more results than the automatically applied limit you'll get incomplete results

#####################################################
# NULL  #############################################
#####################################################

SELECT * FROM movies WHERE year IS NULL;
-- Select everything from the movies table where the year value is null (non-existant). Note that we use IS instead of EQUALS since null has no value and thus can't be equal to a value.

SELECT * FROM movies WHERE year IS NOT NULL ORDER BY year;
-- Select everything from the movies table that has a value in the year column and then order the results by the year. This is a way to filter out null values.

#####################################################
# INSERT  ###########################################
#####################################################

INSERT INTO movies VALUES ("Avatar", 2009);
-- Create a new row of data and place it into the movies table (in the active database) with the values Avatar and 2009.

INSERT INTO movies (title, year) VALUES ("Avatar", 2009);
-- Same as above, but explicitly states the column and value mapping. This is useful in cases where you've forgotten the order you created the values in.

INSERT INTO movies (year, title) VALUES (2009, "Avatar");
-- Same as above, but with the col/values in a different order. It can be whatever order you like. That's the power of explicitly mapping the col/values.

INSERT INTO movies (year, title) VALUES (2009, "Avatar"), (NULL, "Avatar 2");
-- Create two new rows of data and place it into the movies table.

INSERT INTO movies SET title = "Back to the Future", year = 1985;

INSERT INTO genres (name) VALUES("Sci Fi");
INSERT INTO genres (name) VALUES("Action");
INSERT INTO genres (name) VALUES("Musical");
-- Insert three rows of data in the to the genre's table in the name column, which is a unique key, so we can't repeat values.


#####################################################
# UPDATE  ###########################################
#####################################################

--UPDATE works a lot like SELECT. You modify it with WHERE, ORDER BY, etc.

UPDATE movies SET year = 2015;
-- Update the movies table and set the value of the year column to 2015... FOR ALL ROWS. Not what we want to do.

UPDATE movies SET year = 2015 WHERE title = "Avatar 2";
-- Update the movies talbe and set the value of the year column to 2015, for rows where the title column equals Avatar 2.

-- A "Safe Mode" error may pop up.
SET SQL_SAFE_UPDATES = 0;
-- Turns off "safe mode"

SET SQL_SAFE_UPDATES = 1;
-- Turns on "safe mode"


UPDATE movies SET genre_id = 1000 WHERE id = 8 OR id = 9;
-- Tries to update the data in the movies table, by setting the column genre_id to the value of 1000 where the id of the row equals 8 or 9.
-- This fails because there is a foreign key constraint which only allows the genre_id column to be a value found in the genres table id column.

UPDATE movies SET genre_id = 1 WHERE id = 8 OR id = 9;
-- Updates the data in the movies table of the active database and sets the valudes in the genre_id column to 1 in cases where the id column equal 8 or 9. 



#####################################################
# DELETE  ###########################################
#####################################################

DELETE FROM movies;
-- Deletes all the data (rows) from the movies table.

DELETE FROM movies WHERE title = "Avatar" AND year = 2009;
-- Delete rows from the movies table where the title equals Avatar and the year equals 2009.

#####################################################
# TERMINOLOGY  ######################################
#####################################################

# ::: Normalization :::
# ---------------------

-- Describes the process of setting up a table that contains repeated and redundant data from one column of a table and putting that information into another table


# ::: Primary Keys ::: 
# --------------------

# (example: id)

-- A key used to uniquely define each row in a table.
-- Multiple movies can have the same name, so we need something unique like a number to distinguish them.
-- Can't be NULL
-- Can't be duplicated


# ::: Unique Keys :::
# -------------------

# (example: email_address or ssn)

-- Similar to a primary key, but it can be null.
-- Enforce uniqueness
-- Can be null, unless you specify otherwise
-- Can't be duplicated


# ::: Foreign Keys :::
# --------------------

# (example: genre_id)

-- Sometimes known as reference keys. These are special keys that describe the relationship between data in two tables.
-- They can be null.
-- They can be duplicated.


