# CSE 414 Homework 2: Basic SQL
 
**Objectives:** To create and import tables and practice simple SQL queries using SQLite.

**What to turn in:** `create-tables.sql` and `hw2-q1.sql`, `hw2-q2.sql`, etc (see below).

## Assignment Details

In this homework, you will write several SQL queries on a relational flights database. 
The data in this database is abridged from the [Bureau of Transportation Statistics](http://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time) .
The database consists of four tables regarding a subset of flights that took place in 2015:

```SQL
FLIGHTS (fid int, 
         month_id int,        -- 1-12
         day_of_month int,    -- 1-31 
         day_of_week_id int,  -- 1-7, 1 = Monday, 2 = Tuesday, etc
         carrier_id varchar(7), 
         flight_num int,
         origin_city varchar(34), 
         origin_state varchar(47), 
         dest_city varchar(34), 
         dest_state varchar(46), 
         departure_delay int, -- in mins
         taxi_out int,        -- in mins
         arrival_delay int,   -- in mins
         canceled int,        -- 1 means canceled
         actual_time int,     -- in mins
         distance int,        -- in miles
         capacity int, 
         price int            -- in $             
         )
         
CARRIERS (cid varchar(7), name varchar(83))
MONTHS (mid int, month varchar(9))
WEEKDAYS (did int, day_of_week varchar(9))
```

(FYI All data except for the capacity and price columns are real.) 
We leave it up to you to decide how to declare these tables and translate their types to sqlite. 
But make sure that your relations include all the attributes listed above.

In addition, make sure you impose the following constraints to the tables above:
- The primary key of the tables are `fid`, `cid`, `mid`, and `did`. Other than these, *do not assume any other attribute(s) is a key / unique across tuples*.
- `Flights.carrier_id` references `Carrier.cid`.
- `Flights.month_id` references `Months.mid`.
- `Flights.day_of_week_id` references `Weekdays.did`.

We provide the flights database as a set of plain-text data files in the linked `.tar.gz` archive. 
Each file in this archive contains all the rows for the named table, one row per line.

In this homework, you need to do two things:

1. import the flights dataset into SQLite;
2. run SQL queries to answer a set of questions about the data.


### IMPORTING THE FLIGHTS DATABASE (20 points)

#### A primer on `.db` files
When you run the command `sqlite3`, sqlite loads a "transient, in-memory database" which is used for all actions.
This includes importing data. If you load sqlite3 this way, then the `.import` sqlite command will load data into the transient database.
When you exit sqlite, your data will disappear; you will have to re-import the data the next time you start sqlite.

When you run the command `sqlite3 filename.db`, sqlite loads a database with a "backing store".
All commands you run, including `.import` commands, `create table` statements, `insert into` statements, etc., update the backing store (i.e., the file `filename.db`).
If you exit sqlite and run `sqlite3 filename.db` again, you will load the same database state as when you exited.

### Importing data

Before you can import data into sqlite, you need to have a table created to import data into.
Run `CREATE TABLE` statements to create the tables (flights, carriers, months, weekdays), 
choosing appropriate types for each column and specifying all key constraints as described above:

```
CREATE TABLE table_name ( ... );
```

Currently, SQLite does not enforce foreign keys by default. 
To enable foreign keys use the following command. 
The command will have no effect if you installed your own version of SQLite and it was not compiled with foreign keys enabled. 
In that case do not worry about it (i.e., you will need to enforce foreign key constraints yourself as you insert data into the table).

```
PRAGMA foreign_keys=ON;
```

Then, you can use the SQLite `.import` command to read data from each text file into its table after setting the input data to be in CSV (comma separated value) form:

```
.mode csv
.import filename tablename
```

**Question**: does the order of `create table` statements or `.import` statements matter? You don't have to answer this, but knowing the answer will help!

See examples of `.import` statements in the section notes, and also look at the SQLite documentation.
Indeed, one of the goals of this course is to help you learn how to figure out where to look for help!

Put all the code for this part (four `create table` statements and four `.import` statements) 
into a file called `create-tables.sql`.


### Writing SQL QUERIES (80 points, 10 points each)

**HINT: All the questions below are answerable with SQL queries that do NOT contain subqueries!**

**Also, please do not place dotcommands (like .header) in your SQL query files.**

For each question below, write a single SQL query to answer that question.
Put each of your queries in a separate `.sql` file as in hw1, i.e., `hw2-q1.sql`, `hw2-q2.sql`, etc.
Add a SQL comment in each file indicating the number of rows in the query result. 
(Double check that your files are executable.)

**Important: The predicates in your queries should correspond to the English descriptions. 
For example, if a question asks you to find flights by Alaska Airlines Inc., 
your answer should include a predicate that checks for the *specific name* "Alaska Airlines Inc." as opposed to checking for the matching carrier ID "AS". 
Same for predicates over months, weekdays, etc.**

**Also, make sure you name the output columns as indicated! Do not change the output column names / return more or fewer columns!**

In the following questions below flights **include canceled flights, unless otherwise noted.** 
Also, when asked to output times you can report them in minutes and don’t need to do minute-hour conversion.

If a query uses a `GROUP BY` clause, make sure that all attributes in your `SELECT` clause for that query 
are either grouping keys or aggregate values. SQLite will let you select other attributes but that is bad form,
as discussed in lecture. Other database systems would reject such queries.


1. (10 points) List the distinct flight numbers of all flights from Seattle to Boise by "Alaska Airlines Inc." on Fridays. 
Also notice that, in the database, the city names include the state. So Seattle appears as "Seattle WA".
   Name the output column `flight_num`.    
   [Hint: Output relation cardinality: 3 rows]

2. (10 points) Find all itineraries from Boston to Seattle on July 4th. 
Search only for itineraries that have one stop (i.e., flight 1: Boston -> [somewhere], flight2: [somewhere] -> Seattle).
Both flights must depart on the same day (same day here means the date of flight) and must be with the same carrier. 
It's fine if the landing date is different from the departing date (i.e., in the case of an overnight flight). 
You don't need to check whether the first flight overlaps with the second one since the departing and arriving time of flights are not provided. 
The total flight time (`actual_time`) of the entire itinerary should be fewer than 8 hours (but notice that `actual_time` is in minutes). 

   For each itinerary, the query should return the name of the carrier, the first flight number, 
the origin and destination of that first flight, the flight time, the second flight number, 
the origin and destination of the second flight, the second flight time, and finally the total flight time. 
Only count flight times here; do not include any layover time.

    Name the output columns `name` as the name of the carrier, `f1_flight_num`, `f1_origin_city`, `f1_dest_city`, `f1_actual_time`, `f2_flight_num`, `f2_origin_city`, `f2_dest_city`, `f2_actual_time`, and `actual_time` as the total flight time. List the output columns in this order.
    [Output relation cardinality: 1194 rows]


3. (10 points) Find the day of the week with the shortest average arrival delay. 
Return the name of the day and the average delay.   
   Name the output columns `day_of_week` and `delay`, in that order. 
   (Hint: recognize that this is a witness problem. The `LIMIT` keyword may simplify your query.)
   [Output relation cardinality: 1 row]


4. (10 points) Find the names of airlines that ever flew more than 1000 flights in one day (i.e., a specific day/month, not any 24-hour period). 
Return only the names of the airlines. Do not return duplicates (i.e., airlines with the exact same name).    
   Name the output column `name`.   
   [Output relation cardinality: 12 rows]


5. (10 points) Find airlines that had at least 0.6 percent (that is, a proportion of 0.006) of their flights from Seattle canceled. 
Return the name of the airline and the percentage of canceled flight out of Seattle. 
Order the results by the percentage of canceled flights in descending order.    
   Name the output columns `name` and `percent`, in that order.   
   [Output relation cardinality: 6 rows]


6. (10 points) Find the cheapest price of tickets between Seattle and New York, NY (i.e. Seattle to New York or New York to Seattle) for each carrier that offers flights between them. 
Show the cheapest price for each airline that offers flights between the two cities separately.
   Name the output columns `carrier` (i.e., the name of the carrier, not its carrier id) and `min_price`, in that order.   
   [Output relation cardinality: 3 rows]


7. (10 points) Find the total capacity of all direct flights that fly between Seattle and San Francisco on July 11th (i.e. Seattle to San Francisco or San Francisco to Seattle).   
   Name the output column `capacity`.   
   [Output relation cardinality: 1 row]
   
   
8. (10 points) Compute the total departure delay of each airline across all their **non-canceled** flights.
   Name the output columns `name` and `delay`, in that order.
   [Output relation cardinality: 22 rows]


### Programming style 
Remember to adhere to the SQL style guide from HW1. In short, please follow two simple style rules:

- Give explicit names to all tables referenced in the `FROM` clause.
For instance, instead of writing:
   ``` 
   select * from flights, carriers where carrier_id = cid
   ```
   write
   ```
   select * from flights as F, carriers as C where F.carrier_id = C.cid
   ```
   (notice the `as`) so that it is clear which table you are referring to.


- Similarly, references to attributes must be qualified by the table name.
Instead of writing:
   ```
   select * from flights where fid = 1
   ```
   write
   ```
   select * from flights as F where F.fid = 1
   ```
   This will be useful when you write queries involving self joins in later assignments.


