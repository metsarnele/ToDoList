SELECT version();

CREATE DATABASE postgrestask_management;

CREATE TYPE task_status AS ENUM ('pending', 'in_progress', 'completed');

-- Table: users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY, -- PostgreSQL kasutab SERIAL-i ID-de jaoks
    name VARCHAR(191) NOT NULL,
    email VARCHAR(191) NOT NULL UNIQUE,
    password_hash VARCHAR(191) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: tasks
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY, -- PostgreSQL kasutab SERIAL-i ID-de jaoks
    user_id INT NOT NULL,
    title VARCHAR(191) NOT NULL,
    description TEXT,
    status task_status DEFAULT 'pending',
    due_date DATE,
    priority SMALLINT DEFAULT 3, -- 1=High, 2=Medium, 3=Low
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: tags
CREATE TABLE tags (
    tag_id SERIAL PRIMARY KEY, -- PostgreSQL kasutab SERIAL-i ID-de jaoks
    name VARCHAR(191) NOT NULL UNIQUE
);

-- Table: task_tags (many-to-many relationship between tasks and tags)
CREATE TABLE task_tags (
    task_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (task_id, tag_id),
    CONSTRAINT fk_task FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tag FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: tasks_log
CREATE TABLE tasks_log (
    log_id SERIAL PRIMARY KEY,
    task_id INT NOT NULL,
    old_status task_status,
    new_status task_status,
    changed_by INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_task_log FOREIGN KEY (task_id) REFERENCES tasks(task_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_log FOREIGN KEY (changed_by) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Kommentaarid
COMMENT ON COLUMN tasks.priority IS '1=High, 2=Medium, 3=Low';

INSERT INTO users (name, email, password_hash)
VALUES ('John Doe', 'john.doe@example.com', 'hashed_password');

INSERT INTO tasks (user_id, title, description, status, due_date, priority)
VALUES (1, 'Complete Documentation', 'Finalize all docs', 'in_progress', '2024-12-20', 1);

