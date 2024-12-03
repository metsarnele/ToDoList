DELIMITER $$

-- TRIGGER: after_tasks_update
-- See trigger logib muudatused, mis tehakse "tasks" tabeli staatuse veerus.
-- Kui staatust muudetakse, salvestatakse vana ja uus staatus "tasks_log" tabelisse koos muudatuse teinud kasutajaga.
CREATE TRIGGER after_tasks_update
AFTER UPDATE ON tasks
FOR EACH ROW
BEGIN
    -- Logi ainult siis, kui staatus on tegelikult muutunud
    IF OLD.status != NEW.status THEN
        INSERT INTO tasks_log (task_id, old_status, new_status, changed_by, changed_at)
        VALUES (OLD.task_id, OLD.status, NEW.status, NEW.user_id, NOW());
    END IF;
END;
$$

DELIMITER ;

DELIMITER $$

-- TRIGGER: before_users_insert
-- See trigger kontrollib andmete terviklikkust enne uue kasutaja sisestamist "users" tabelisse.
-- See valideerib e-posti aadressi formaadi ja kontrollib, kas parool on piisavalt pikk.
CREATE TRIGGER before_users_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    -- Kontrolli, kas e-posti aadress on kehtiv
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'E-posti aadressi formaat on vale.';
    END IF;

    -- Kontrolli, kas parool on vähemalt 8 tähemärki pikk
    IF LENGTH(NEW.password_hash) < 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Parool peab olema vähemalt 8 tähemärki pikk.';
    END IF;
END;
$$

DELIMITER ;
