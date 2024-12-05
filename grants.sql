-- Creating the admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '123';

-- Granting all privileges on the database to the admin user
GRANT ALL PRIVILEGES ON todo_db.* TO 'admin_user'@'localhost';

-- Creating the regular user
CREATE USER 'regular_user'@'localhost' IDENTIFIED BY '123';

-- Granting only SELECT permissions on the database to the regular user
GRANT SELECT ON todo_db.* TO 'regular_user'@'localhost';

FLUSH PRIVILEGES;

-- Login with regular_user

SELECT * FROM tasks;

UPDATE tasks SET status = 'completed' WHERE task_id = 1;
-- Should throw an error: Access denied

todo_db> SELECT * FROM tasks
[2024-12-05 11:40:17] 1 row retrieved starting from 1 in 654 ms (execution: 8 ms, fetching: 646 ms)
todo_db> UPDATE tasks SET status = 'completed' WHERE task_id = 1
[2024-12-05 11:40:18] [42000][1142] (conn=9) UPDATE command denied to user 'regular_user'@'localhost' for table `todo_db`.`tasks`


-- Login with admin_user
INSERT INTO tasks (user_id, title, description, status) VALUES (1, 'Admin task', 'Admin test', 'pending');
UPDATE tasks SET status = 'completed' WHERE task_id = 1;
DELETE FROM tasks WHERE task_id = 1;
CREATE TABLE test_table (id INT PRIMARY KEY, name VARCHAR(50));


[2024-12-05 11:43:04] Connected
todo_db> INSERT INTO tasks (user_id, title, description, status) VALUES (1, 'Admin task', 'Admin test', 'pending')
[2024-12-05 11:43:04] 1 row affected in 32 ms
todo_db> UPDATE tasks SET status = 'completed' WHERE task_id = 1
[2024-12-05 11:43:04] 1 row affected in 28 ms
todo_db> DELETE FROM tasks WHERE task_id = 1
[2024-12-05 11:43:04] 1 row affected in 14 ms
todo_db> CREATE TABLE test_table (id INT PRIMARY KEY, name VARCHAR(50))
[2024-12-05 11:43:04] completed in 111 ms

DROP USER 'regular_user'@'localhost';
DROP USER 'admin_user'@'localhost';
