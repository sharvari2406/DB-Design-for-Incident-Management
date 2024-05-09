DELIMITER $$
-- works on L2
CREATE PROCEDURE InsertIntoWorksOnL2()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE empId INT;
    DECLARE caseTicketNum VARCHAR(10);

    -- Insert data into Works_on_L2
    WHILE i <= 100 DO
        SET empId = i;
        SET caseTicketNum = CONCAT('T', LPAD(i, 9, '0'));

        -- Check if emp_id exists in L2_engineers table and case_ticket_number exists in Cases table
        IF EXISTS (SELECT 1 FROM L2_engineers WHERE emp_id = empId) AND EXISTS (SELECT 1 FROM Cases WHERE case_ticket_number = caseTicketNum) THEN
            -- Insert into Works_on_L2
            INSERT INTO Works_on_L2 (emp_id, case_ticket_number)
            VALUES (empId, caseTicketNum);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL InsertIntoWorksOnL2();

-- works on L3

DELIMITER $$

CREATE PROCEDURE InsertIntoWorksOnL3()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE empId INT;
    DECLARE prbTicketNum VARCHAR(10);

    -- Insert data into Works_on_L3
    WHILE i <= 100 DO
        SET empId = i;
        SET prbTicketNum = CONCAT('T', LPAD(i, 9, '0'));

        -- Check if emp_id exists in Problem_Management table and prb_ticket_number exists in Problems table
        IF EXISTS (SELECT 1 FROM Problem_Management WHERE emp_id = empId) AND EXISTS (SELECT 1 FROM Problems WHERE prb_ticket_number = prbTicketNum) THEN
            -- Insert into Works_on_L3
            INSERT INTO Works_on_L3 (emp_id, prb_ticket_number)
            VALUES (empId, prbTicketNum);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL InsertIntoWorksOnL3();

DELIMITER $$

CREATE PROCEDURE InsertIntoWorksOnChanges()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE empId INT;
    DECLARE chgTicketNum VARCHAR(10);

    -- Insert data into Works_on_Changes
    WHILE i <= 100 DO
        SET empId = i;
        SET chgTicketNum = CONCAT('T', LPAD(i, 9, '0'));

        -- Check if emp_id exists in Change_Managers table and chg_ticket_number exists in Changes table
        IF EXISTS (SELECT 1 FROM Change_Managers WHERE emp_id = empId) AND EXISTS (SELECT 1 FROM Changes WHERE chg_ticket_number = chgTicketNum) THEN
            -- Insert into Works_on_Changes
            INSERT INTO Works_on_Changes (emp_id, chg_ticket_number)
            VALUES (empId, chgTicketNum);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL InsertIntoWorksOnChanges();

-- Approvers
DELIMITER $$

CREATE PROCEDURE InsertIntoApprovesChanges()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE empId INT;
    DECLARE chgTicketNum VARCHAR(10);

    -- Insert data into Approves_Changes
    WHILE i <= 100 DO
        SET empId = i;
        SET chgTicketNum = CONCAT('T', LPAD(i, 9, '0'));

        -- Check if emp_id exists in Change_approvers table and chg_ticket_number exists in Changes table
        IF EXISTS (SELECT 1 FROM Change_approvers WHERE emp_id = empId) AND EXISTS (SELECT 1 FROM Changes WHERE chg_ticket_number = chgTicketNum) THEN
            -- Insert into Approves_Changes
            INSERT INTO Approves_Changes (emp_id, chg_ticket_number)
            VALUES (empId, chgTicketNum);
        END IF;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL InsertIntoApprovesChanges();