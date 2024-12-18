SELECT VERSION();

CREATE DATABASE task_management;

-- Table: users
CREATE TABLE users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(191) NOT NULL,
    email VARCHAR(191) NOT NULL UNIQUE,
    password_hash VARCHAR(191) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: tasks
CREATE TABLE tasks (
    task_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    title VARCHAR(191) NOT NULL,
    description TEXT,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    due_date DATE,
    priority TINYINT UNSIGNED DEFAULT 3 COMMENT '1=High, 2=Medium, 3=Low',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: tags
CREATE TABLE tags (
    tag_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(191) NOT NULL UNIQUE
);

-- Table: task_tags (many-to-many relationship between tasks and tags)
CREATE TABLE task_tags (
    task_id INT UNSIGNED NOT NULL,
    tag_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (task_id, tag_id),
    FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: tasks_log
CREATE TABLE tasks_log (
    log_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    task_id INT UNSIGNED NOT NULL,
    old_status ENUM('pending', 'in_progress', 'completed'),
    new_status ENUM('pending', 'in_progress', 'completed'),
    changed_by INT UNSIGNED,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (name, email, password_hash) VALUES
('John Doe', 'john.doe@example.com', 'hashed_password_john'),
('Jane Smith', 'jane.smith@example.com', 'hashed_password_jane'),
('Alice Brown', 'alice.brown@example.com', 'hashed_password_alice'),
('Bob Black', 'bob.black@example.com', 'hashed_password_bob');

INSERT INTO tags (name) VALUES
('Urgent'),
('Work'),
('Personal'),
('High Priority');

INSERT INTO tasks (user_id, title, description, status, due_date, priority) VALUES
(1, 'Complete project report', 'Write and submit the final report', 'in_progress', '2024-12-20', 1),
(3, 'Team meeting', 'Discuss project progress and milestones', 'completed', '2024-12-15', 3),
(4, 'Fix critical bug', 'Resolve the critical issue in production', 'in_progress', '2024-12-18', 1);

