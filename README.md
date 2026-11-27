To run the database file, use the command:

    mysql -u root -p < database.sql

Then login using your MySQL password.

Before running any further commands, enter into mysql using the command:

    mysql -u root -p

---

To run the Project Data file:
While logged into SQL, use the command: 
    
    SOURCE Project Data.sql or SOURCE Project Seed Data.sql;
    
If that does not work, right click the Project Data.sql file in VSCode's file explorer, select "copy path", and run the code:

    SOURCE (copied filepath);

To run the Project Queries file:
While logged into SQL, use the comamnd: 

    SOURCE Project Queries.sql;

If that does not work, right click the Project Queries.sql file in VSCode's file explorer, select "copy path", and run the code:

    SOURCE (copied filepath);


To check if the database has been instantiated properly and the data inside of it:

Use the command: 

    mysql -u root -p

Login using your MySQL password

Use the command 

    SHOW DATABASES;

(can just skip this step but it helps show you if the database is there or not)

Use the command 

    USE ENSF_608_PROJECT;

Use the command 

    SHOW TABLES;

To view the fields of a table use 

    DESCRIBE **Name**;

To view all data in a table use 

    SELECT * FROM **Name**;

When finished use:

    exit;
