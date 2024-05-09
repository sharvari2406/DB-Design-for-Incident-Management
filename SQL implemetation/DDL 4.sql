CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(20),
    customer_email VARCHAR(50),
    phone_number VARCHAR(10)
);
 
CREATE TABLE Can_be (
    emp_id INT,
    customer_id INT,
    PRIMARY KEY (emp_id , customer_id),
    FOREIGN KEY (emp_id)
        REFERENCES Change_approvers (emp_id),
    FOREIGN KEY (customer_id)
        REFERENCES Customer (customer_id)
);
 
CREATE TABLE Associated_to (
    ticket_number varchar(10),
    customer_id INT ,
    primary key (ticket_number, customer_id),
    FOREIGN KEY (ticket_number)
        REFERENCES Tickets (ticket_number),
    FOREIGN KEY (customer_id)
        REFERENCES Customer (customer_id)
);

