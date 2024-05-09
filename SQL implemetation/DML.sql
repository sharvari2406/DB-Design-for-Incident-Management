DELIMITER //
-- Inserting values in Employees, Team_PDL, and KT
CREATE PROCEDURE InsertDataIntoAllTables()
BEGIN
  -- Variables
  DECLARE i INT DEFAULT 1;
  DECLARE teamEmail VARCHAR(50);
  DECLARE assignmentGroup VARCHAR(20);
  DECLARE empName VARCHAR(20);
  DECLARE personalEmail VARCHAR(50);
  DECLARE contactNum VARCHAR(10);
  DECLARE articleNum VARCHAR(20);
  DECLARE articleType VARCHAR(10);
  DECLARE articleContent VARCHAR(1000);

  -- Inserting into Team_PDL (only 4 unique rows possible)
  INSERT INTO Team_PDL (team_email, assignment_group) VALUES
  ('L1_Engineers@dma.com', 'L1_Engineers'),
  ('L2_Engineers@dma.com', 'L2_Engineers'),
  ('Problem_Management@dma.com', 'Problem_Management'),
  ('Change_Management@dma.com', 'Change_Management')
  ON DUPLICATE KEY UPDATE team_email = VALUES(team_email);

  -- Loop for inserting into Employees and Knowledge_Articles
  WHILE i <= 100 DO
    -- Determine team email in a round-robin fashion
    CASE 
      WHEN (i % 4) = 1 THEN SET teamEmail = 'L1_Engineers@dma.com';
      WHEN (i % 4) = 2 THEN SET teamEmail = 'L2_Engineers@dma.com';
      WHEN (i % 4) = 3 THEN SET teamEmail = 'Problem_Management@dma.com';
      ELSE SET teamEmail = 'Change_Management@dma.com';
    END CASE;

    -- Prepare data for Employees and Knowledge_Articles
    SET empName = CONCAT('Employee', i);
    SET personalEmail = CONCAT(empName, '@example.com');
    SET contactNum = CONCAT('123456', LPAD(i, 4, '0'));
    SET articleNum = CONCAT('KA', LPAD(i, 4, '0'));
    SET articleType = IF(i % 2 = 0, 'Tech', 'Non-Tech');
    SET articleContent = CONCAT('Content for article ', i);

    -- Insert into Employees
    INSERT INTO Employees (emp_id, emp_name, personal_email, contact_number, team_email)
    VALUES (i, empName, personalEmail, contactNum, teamEmail);

    -- Insert into Knowledge_Articles
    INSERT INTO Knowledge_Articles (article_number, article_type, created_by, article_content, emp_id)
    VALUES (articleNum, articleType, empName, articleContent, i);

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;
CALL InsertDataIntoAllTables();


-- Inserting values in L1
DELIMITER //

CREATE PROCEDURE InsertIntoL1Engineers()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE currentTeamEmail VARCHAR(50);
  DECLARE empExists INT;

  WHILE i <= 100 DO
    -- Check if the employee ID already exists in L1_engineers
    SELECT COUNT(*) INTO empExists FROM L1_engineers WHERE emp_id = i;

    IF empExists = 0 THEN
      -- Fetch the team email for the current employee
      SELECT team_email INTO currentTeamEmail FROM Employees WHERE emp_id = i;

      -- Check if the employee is part of L1_Engineers
      IF currentTeamEmail = 'L1_Engineers@dma.com' THEN
        -- Insert into L1_engineers
        INSERT INTO L1_engineers (emp_id) VALUES (i);
      END IF;
    END IF;

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;
CALL InsertIntoL1Engineers();

DELIMITER //
-- Insert into L2Engineers
CREATE PROCEDURE InsertIntoL2Engineers()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE currentTeamEmail VARCHAR(50);

  WHILE i <= 100 DO
    SELECT team_email INTO currentTeamEmail FROM Employees WHERE emp_id = i;
    IF currentTeamEmail = 'L2_Engineers@dma.com' THEN
      INSERT INTO L2_engineers (emp_id) VALUES (i);
    END IF;
    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

DELIMITER //
-- Insert into Problemmanagers
CREATE PROCEDURE InsertIntoProblemManagement()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE currentTeamEmail VARCHAR(50);

  WHILE i <= 100 DO
    SELECT team_email INTO currentTeamEmail FROM Employees WHERE emp_id = i;
    IF currentTeamEmail = 'Problem_Management@dma.com' THEN
      INSERT INTO Problem_Management (emp_id) VALUES (i);
    END IF;
    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

DELIMITER //
-- Insert into Changemanagers
CREATE PROCEDURE InsertIntoChangeManagers()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE currentTeamEmail VARCHAR(50);

  WHILE i <= 100 DO
    SELECT team_email INTO currentTeamEmail FROM Employees WHERE emp_id = i;
    IF currentTeamEmail = 'Change_Management@dma.com' THEN
      INSERT INTO Change_Managers (emp_id) VALUES (i);
    END IF;
    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

DELIMITER //
-- Insert into Changeapprovers
CREATE PROCEDURE InsertIntoChangeApprovers()
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= 100 DO
    -- Assuming every 5th employee is a change approver, adjust as needed
    IF i % 5 = 0 THEN
      INSERT INTO Change_approvers (emp_id) VALUES (i);
    END IF;
    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;


CALL InsertIntoL1Engineers();
CALL InsertIntoL2Engineers();
CALL InsertIntoProblemManagement();
CALL InsertIntoChangeManagers();
CALL InsertIntoChangeApprovers();

