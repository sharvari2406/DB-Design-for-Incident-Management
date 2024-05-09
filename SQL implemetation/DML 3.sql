DELIMITER $$
-- Comments data
CREATE PROCEDURE InsertCommentsData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE ticketNum VARCHAR(10);

    -- Inserting 100 entries into Comments
    WHILE i <= 100 DO
        SET ticketNum = CONCAT('T', LPAD(i, 9, '0'));
        INSERT INTO Comments (ticket_number, follow_up_number, ts_steps, POA, next_follow_up)
        VALUES (ticketNum, i, CONCAT('Step ', i), 'callback scheduled', NOW() + INTERVAL i DAY);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL InsertCommentsData();


-- works on L1
DELIMITER $$

CREATE PROCEDURE InsertIntoWorksOnL1()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE empId INT;
    DECLARE incTicketNum VARCHAR(10);

    -- Insert data into Works_on_L1
    WHILE i <= 100 DO
        SET empId = i;
        SET incTicketNum = CONCAT('T', LPAD(i, 9, '0'));

        -- Check if the inc_ticket_number exists in the incidents table
        IF EXISTS (SELECT 1 FROM Incidents WHERE inc_ticket_number = incTicketNum) THEN
            -- Insert into Works_on_L1
            INSERT INTO Works_on_L1 (emp_id, inc_ticket_number)
            VALUES (empId, incTicketNum);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;


CALL InsertIntoWorksOnL1();
