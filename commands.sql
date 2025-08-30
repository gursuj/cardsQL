-- these are for SQLite so some syntax may vary if you use a differentd RDBMS

-- folders are used to group together related cards
create table folders(
    id integer primary key check(id > 0),
    name text not null unique check(length(name) <= 255)
);
insert into folders(id, name) values(1, 'Default');

-- front & back values are required when inserting new cards
-- others have default values set, so optional
-- id will also get auto incremented if not specified (due to being integer primary key)
create table cards(
    id integer primary key check(id > 0),
    front text not null check(length(front) <= 255),
    back text not null check(length(back) <= 255),
    direction text not null default 'forward' check(direction in ('disabled','forward','backward','both')),
    successfulRevisions int not null default 0 check(successfulRevisions >= 0),
    easeFactor real not null default 2.5 check(
        easeFactor <= 2.5
        AND easeFactor >= 1.3
    ),
    interval int not null default 1 check(interval >= 0),
    scheduledDate text not null default CURRENT_DATE check (
        length(scheduledDate) <= 10
        AND DATE(scheduledDate, '+0 days') IS scheduledDate
    ),
    folder_id integer default 1 references folders(id)
) strict;
-- NOTE: CURRENT_DATE returns date as text in YYYY-MM-DD format

-- seed w/ starter questions
insert into cards(front, back) values('What''s the difference between a stack and a queue?', 'A stack is like a pile of plates (last one on, first one off), and a queue is like a line at a store (first one in, first one out).');
insert into cards(front, back) values('What is "time complexity"?', 'It''s how fast an algorithm runs as the input gets bigger, often described with Big O notation.');
insert into cards(front, back) values('What is recursion?', 'When a function calls itself to solve a smaller part of the same problem.');
insert into cards(front, back) values('Why use a foreign key?', 'It links data in one table to data in another, like connecting a student to their classes.');
insert into cards(front, back) values('What is polymorphism?', 'When an object can take on many forms, allowing a single action to behave differently depending on the object.');
insert into cards(front, back) values('What is the CAP theorem?', 'A principle in distributed systems stating you can only have two of these three guarantees at the same time: Consistency, Availability, and Partition Tolerance.');
insert into cards(front, back) values('What is the difference between an inner join and a left join in SQL?', 'An inner join returns only rows that have matching values in both tables. A left join returns all rows from the left table, and the matching rows from the right table.');
insert into cards(front, back) values('Explain the concept of a "race condition."', 'A race condition is when multiple processes or threads try to access and change the same data at the same time, leading to unpredictable results.');
insert into cards(front, back) values('What is a hash table?', 'A data structure that stores data using a key-value pair, allowing for very fast data retrieval by using a hash function to map keys to an index.');
insert into cards(front, back) values('What is the difference between a process and a thread?', 'A process is an independent program with its own memory space, while a thread is a smaller unit of execution within a process that shares the same memory space.');

-- MAYBE: implement some way to prevent insertion here, or limit to 1 row
create table misc(
    dailyTarget integer default 10 check(dailyTarget > 0),
    dailyStreak integer default 0 check(dailyStreak >0)
);
