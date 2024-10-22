show databases;
-- create a new database
create databases ecommerce;
-- change the active database
use swimming_coach;
-- create a new table
create table parents(
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null,
    last_name varchar(200)default''
) engine innodb;

-- create student table
create table students(
    student_id mediumint unsigned auto_increment primary key,
    name varchar(200) not null,
    date_of_birth datetime not null
) engine = innodb;

-- alter table
ALTER TABLE students ADD COLUMN parent_id INT UNSIGNED;

--  Use Decribe to show fields definitions
DESCRIBE students;

ALTER TABLE students ADD CONSTRAINT fk_students_parents
FOREIGN KEY (parent_id) REFERENCES parents(parent_id);

ALTER TABLE students MODIFY COLUMN parent_id INT UNSIGNED NOT NULL;

--  add new data 
-- insert into < table name> ( col1, col2)
INSERT INTO parents(first_name, last_name) VALUES ("John", "Wick")
-- see all the rows from the table
-- SELECT* - all columns
SELECT * FROM parents;

INSERT INTO students (name,date_of_birth,parent_id) VALUES ("Jon Snow","1983","1")

-- Delete remove

