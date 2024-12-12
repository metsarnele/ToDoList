SELECT
    users.name AS user_name,
    users.email AS user_email,
    tasks.title AS task_title,
    tasks.status AS task_status,
    tasks.due_date AS task_due_date
FROM
    tasks
INNER JOIN
    users ON tasks.user_id = users.user_id
WHERE
    tasks.status = 'pending' -- Only fetch tasks that are pending
ORDER BY
    tasks.due_date ASC; -- Sort tasks by their due date in ascending order

todo_db> SELECT
             users.name AS user_name,
             users.email AS user_email,
             tasks.title AS task_title,
             tasks.status AS task_status,
             tasks.due_date AS task_due_date
         FROM
             tasks
         INNER JOIN
             users ON tasks.user_id = users.user_id
         WHERE
             tasks.status = 'pending' -- Only fetch tasks that are pending
         ORDER BY
             tasks.due_date ASC
[2024-12-12 12:44:40] 2 rows retrieved starting from 1 in 260 ms (execution: 47 ms, fetching: 213 ms)