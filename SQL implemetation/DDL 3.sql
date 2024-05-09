CREATE TABLE Comments (
    ticket_number VARCHAR(10),
    follow_up_number INT,
    ts_steps VARCHAR(100),
    POA VARCHAR(100),
    CONSTRAINT cc7 CHECK (POA IN ('callback scheduled' , 'under monitoring',
        'Tech visit scheduled',
        'Awaiting for customer callback',
        'waiting for vendor update',
        'others')),
    next_follow_up DATETIME,
    primary key (ticket_number,follow_up_number),
    foreign key (ticket_number) references Tickets(ticket_number)
);

CREATE TABLE Works_on_L1 (
    emp_id INT,
    inc_ticket_number VARCHAR(10),
    PRIMARY KEY (emp_id, inc_ticket_number),
    FOREIGN KEY (emp_id) REFERENCES L1_engineers(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (inc_ticket_number) REFERENCES Incidents(inc_ticket_number) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Works_on_L2 (
    emp_id INT,
    case_ticket_number VARCHAR(10),
    PRIMARY KEY (emp_id, case_ticket_number),
    FOREIGN KEY (emp_id) REFERENCES L2_engineers(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (case_ticket_number) REFERENCES Cases(case_ticket_number) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Works_on_L3 (
    emp_id INT,
    prb_ticket_number VARCHAR(10),
    PRIMARY KEY (emp_id, prb_ticket_number),
    FOREIGN KEY (emp_id) REFERENCES Problem_Management(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (prb_ticket_number) REFERENCES Problems(prb_ticket_number) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Works_on_Changes (
    emp_id INT,
    chg_ticket_number VARCHAR(10),
    PRIMARY KEY (emp_id, chg_ticket_number),
    FOREIGN KEY (emp_id) REFERENCES Change_Managers(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chg_ticket_number) REFERENCES Changes(chg_ticket_number) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Approves_Changes (
    emp_id INT,
    chg_ticket_number VARCHAR(10),
    PRIMARY KEY (emp_id, chg_ticket_number),
    FOREIGN KEY (emp_id) REFERENCES Change_approvers(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chg_ticket_number) REFERENCES Changes(chg_ticket_number) ON UPDATE CASCADE ON DELETE CASCADE
);


