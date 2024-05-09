DELIMITER $$

CREATE PROCEDURE InsertSampleData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE resCode VARCHAR(100);

    -- Inserting unique entries into Resolution
    INSERT INTO Resolution (resolution_code, resolution_notes) VALUES
        ('remote fix', 'Note for remote fix'),
        ('reboot', 'Note for reboot'),
        ('replacement', 'Note for replacement'),
        ('vendor resolved', 'Note for vendor resolved'),
        ('updated configuration', 'Note for updated configuration'),
        ('others', 'Note for others');

    -- Inserting 100 entries into Tickets
    WHILE i <= 100 DO
        SET resCode = ELT(MOD(i, 6) + 1, 'remote fix', 'reboot', 'replacement', 'vendor resolved', 'updated configuration', 'others');
        INSERT INTO Tickets (ticket_number, case_status, short_desc, case_desc, issue_type, assigned_to, resolution_code, resolution_notes)
        VALUES (CONCAT('T', LPAD(i, 9, '0')), 'new', CONCAT('Short Desc ', i), CONCAT('Case Desc ', i), 'wired', CONCAT('Assignee', i), resCode, CONCAT('Note for ', resCode));
        SET i = i + 1;
    END WHILE;
    SET i = 1;

    -- Inserting 100 entries into Changes
    WHILE i <= 100 DO
        INSERT INTO Changes (chg_ticket_number) VALUES (CONCAT('T', LPAD(i, 9, '0')));
        SET i = i + 1;
    END WHILE;
    SET i = 1;

    -- Inserting 100 entries into Problems
    WHILE i <= 100 DO
        INSERT INTO Problems (prb_ticket_number, chg_ticket_number) VALUES (CONCAT('T', LPAD(i, 9, '0')), CONCAT('T', LPAD(i, 9, '0')));
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL InsertSampleData();



