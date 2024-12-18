SELECT 1

HMSET user:1 user_id 1 name "John Doe" email "john.doe@example.com" password_hash "hashed_password_john" created_at "2024-12-18" updated_at "2024-12-18"

HMSET task:1 task_id 1 user_id 1 title "Complete project report" description "Write and submit the final report" status "in_progress" due_date "2024-12-20" priority 1 created_at "2024-12-18" updated_at "2024-12-18"

HMSET tag:1 tag_id 1 name "Urgent"

HMSET log:1 log_id 1 task_id 1 old_status "pending" new_status "in_progress" changed_by 1 changed_at "2024-12-16 10:00:00"

