DELIMITER //

CREATE PROCEDURE Insert100Customers()
BEGIN
    DECLARE counter INT DEFAULT 1;

    WHILE counter <= 100 DO
        INSERT INTO Customer (customer_id, customer_name, customer_email, phone_number)
        VALUES (counter, CONCAT('Customer', counter), CONCAT('customer', counter, '@example.com'), CONCAT('1234567', counter));
        
        SET counter = counter + 1;
    END WHILE;
END //



DELIMITER ;
CALL Insert100Customers();

DELIMITER //

CREATE PROCEDURE Insert100Can_beRecords()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_customer_id INT;
    DECLARE random_emp_id INT;
    DECLARE combination_exists INT;
    DECLARE emp_exists INT;
    DECLARE customer_exists INT;

    WHILE i <= 100 DO
        -- Select a random emp_id and customer_id
        SET random_customer_id = FLOOR(RAND() * 100) + 1;
        SET random_emp_id = FLOOR(RAND() * 100) + 1;

        -- Check if emp_id exists in Change_approvers
        SELECT COUNT(*) INTO emp_exists 
        FROM Change_approvers 
        WHERE emp_id = random_emp_id;

        -- Check if customer_id exists in Customer
        SELECT COUNT(*) INTO customer_exists 
        FROM Customer 
        WHERE customer_id = random_customer_id;

        -- Check if the combination of emp_id and customer_id already exists in Can_be
        SELECT COUNT(*) INTO combination_exists 
        FROM Can_be 
        WHERE emp_id = random_emp_id AND customer_id = random_customer_id;

        -- Insert only if emp_id and customer_id exist and the combination does not exist
        IF emp_exists > 0 AND customer_exists > 0 AND combination_exists = 0 THEN
            INSERT INTO Can_be (emp_id, customer_id)
            VALUES (random_emp_id, random_customer_id);
        END IF;

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
call Insert100Can_beRecords();

DELIMITER $$

CREATE PROCEDURE Insert100AssociatedRecords()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE ticket_num VARCHAR(10);

    WHILE counter <= 100 DO
        SET ticket_num = CONCAT('T', LPAD(counter, 9, '0')); -- Assuming ticket_number format as in your previous procedure

        INSERT INTO Associated_to (ticket_number, customer_id)
        VALUES (ticket_num, counter);
        
        SET counter = counter + 1;
    END WHILE;
END $$

DELIMITER ;
CALL Insert100AssociatedRecords();


