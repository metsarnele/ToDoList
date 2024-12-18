CREATE DATABASE MicrosoftSQL;

Use MicrosoftSQL;

-- Table: users
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY as AUTO_INCREMENT
    name NVARCHAR(191) NOT NULL,          -- NVARCHAR for Unicode support
    email NVARCHAR(191) NOT NULL UNIQUE,  -- Unikaalne e-post
    password_hash NVARCHAR(191) NOT NULL, -- Parooli hash
    created_at DATETIME DEFAULT GETDATE(), -- Loomeaeg
    updated_at DATETIME DEFAULT GETDATE()  -- Uuendamise aeg
);

-- Table: tasks
CREATE TABLE tasks (
    task_id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY for auto-increment
    user_id INT NOT NULL,                  -- Viide kasutajale
    title NVARCHAR(191) NOT NULL,          -- Ülesande pealkiri
    description NVARCHAR(MAX),             -- Ülesande kirjeldus
    status NVARCHAR(20) DEFAULT 'pending', -- Asendame ENUM-i NVARCHAR-iga
    due_date DATE,                         -- Tähtaeg
    priority TINYINT DEFAULT 3,            -- Prioriteet (1=High, 2=Medium, 3=Low)
    created_at DATETIME DEFAULT GETDATE(), -- Loomeaeg
    updated_at DATETIME DEFAULT GETDATE(), -- Uuendamise aeg
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table: tags
CREATE TABLE tags (
    tag_id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY as AUTO_INCREMENT
    name NVARCHAR(191) NOT NULL UNIQUE   -- Sildi nimi
);

-- Table: task_tags
CREATE TABLE task_tags (
    task_id INT NOT NULL,                -- Viide ülesandele
    tag_id INT NOT NULL,                 -- Viide sildile
    PRIMARY KEY (task_id, tag_id),       -- Kombineeritud primaarvõti
    CONSTRAINT fk_task FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE,
    CONSTRAINT fk_tag FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);

-- Table: tasks_log
CREATE TABLE tasks_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY for auto-increment
    task_id INT NOT NULL,                 -- Viide ülesandele
    old_status NVARCHAR(20),              -- Asendame ENUM-i NVARCHAR-iga
    new_status NVARCHAR(20),              -- Asendame ENUM-i NVARCHAR-iga
    changed_by INT,                       -- Viide muutjale
    changed_at DATETIME DEFAULT GETDATE(), -- Muutmise aeg
    CONSTRAINT fk_task_log FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_log FOREIGN KEY (changed_by) REFERENCES users(user_id) ON DELETE NO ACTION
);

INSERT INTO users (name, email, password_hash) VALUES
('John Doe', 'john.doe@example.com', 'hashed_password_john'),
('Jane Smith', 'jane.smith@example.com', 'hashed_password_jane'),
('Alice Brown', 'alice.brown@example.com', 'hashed_password_alice'),
('Bob Black', 'bob.black@example.com', 'hashed_password_bob');

INSERT INTO tasks (user_id, title, description, status, due_date, priority) VALUES
(1, 'Complete project report', 'Write and submit the final report', 'in_progress', '2024-12-20', 1),
(2, 'Prepare presentation', 'Design slides for the client meeting', 'pending', '2024-12-22', 2),
(3, 'Team meeting', 'Discuss project progress and milestones', 'completed', '2024-12-15', 3),
(4, 'Fix critical bug', 'Resolve the critical issue in production', 'in_progress', '2024-12-18', 1);

INSERT INTO tags (name) VALUES
('Urgent'),
('Work'),
('Personal'),
('High Priority');

