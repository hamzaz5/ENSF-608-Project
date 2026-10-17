To run the database file:

    Use the command 'mysql -u root -p < database.sql'

    Login using your MySQL password

To check if the database has been instantiated properlly and the data inside of it:

    Use the command 'mysql -u root -p'

    Login using your MySQL password

    Use the command 'SHOW DATABASES;' (can just skip this step but it helps show you if the database is there or not)

    Use the command 'USE TEMPNAME;' (placeholder name for now)

    Use the command 'SHOW TABLES;'

    To view the fields of a table use 'DESCRIBE **Name**;'

    To view all data in a table use 'SELECT * FROM **Name**;'

    When finished use 'exit;'



Changes made that impact the ER diagram (basically everything that is a type and had to be renamed):

    - school_address used for address in school due to address being a type
    - CLASSES used for Class Entity due to CLASS being a type
    - award_description used for description in award due to description being a type
    - goal_status used for status in goals due to status being a type
    - reminder_status used for status in reminders due to status being a type
    - reminder_message used for message in reminders due to message being a type
    - SESSIONTABLE used for Session Entity due to SESSION being a type
    - session_status used for status in session due to status being a type
    - item_description used for description in actionitem due to description being a type
    - item_status used for status in actionitem due to status being a type


Things that are missing (from tables that are already created):

    - Temp values to be determined later
    - Not all relationships are implemented (Check each table in accordance with the ER Diagram)
    - Certain attributes are commented out due to uncertainty about type of data being stored or format
