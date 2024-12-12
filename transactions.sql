-- Begin the transaction
START TRANSACTION;

-- Insert a new user and retrieve the ID in one step
INSERT INTO users (name, email, password_hash)
VALUES ('John', 'john@example.com', 'hashed_password_1234');
SET @last_user_id = LAST_INSERT_ID();

-- Add a task for the user
INSERT INTO tasks (user_id, title, description, status, due_date, priority)
VALUES (@last_user_id, 'Finish project', 'Complete the database transaction implementation', 'in_progress', '2024-12-31', 1);


-- Commit the transaction if all operations are successful
COMMIT;

todo_db> START TRANSACTION
[2024-12-12 12:18:46] completed in 2 ms
todo_db> INSERT INTO users (name, email, password_hash)
         VALUES ('John', 'john@example.com', 'hashed_password_1234')
[2024-12-12 12:18:47] 1 row affected in 20 ms
todo_db> SET @last_user_id = LAST_INSERT_ID()
[2024-12-12 12:18:47] completed in 7 ms
todo_db> INSERT INTO tasks (user_id, title, description, status, due_date, priority)
         VALUES (@last_user_id, 'Finish project', 'Complete the database transaction implementation', 'in_progress', '2024-12-31', 1)
[2024-12-12 12:18:47] 1 row affected in 6 ms
todo_db> COMMIT
[2024-12-12 12:18:47] completed in 9 ms

-- Intentional failure to test ROLLBACK
-- Add a task with an invalid user
INSERT INTO tasks (user_id, title, description, status, due_date, priority)
VALUES (NULL, 'Faulty Task', 'This task will cause ROLLBACK', 'pending', '2024-12-25', 99);

todo_db> INSERT INTO tasks (user_id, title, description, status, due_date, priority)
         VALUES (NULL, 'Faulty Task', 'This task will cause ROLLBACK', 'pending', '2024-12-25', 99)
[2024-12-12 12:19:59] [23000][1048] (conn=23) Column 'user_id' cannot be null

todo_db> ROLLBACK
[2024-12-12 12:21:20] completed in 24 ms
