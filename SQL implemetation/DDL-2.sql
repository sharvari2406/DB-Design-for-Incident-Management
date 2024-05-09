USE dma_project;

CREATE TABLE Resolution (
    resolution_code VARCHAR(100),
    resolution_notes VARCHAR(100),
    PRIMARY KEY (resolution_code),
    CONSTRAINT CC6 CHECK (resolution_code IN ('remote fix', 'reboot', 'replacement', 'vendor resolved', 'updated configuration', 'others'))
);


CREATE TABLE Tickets (
    ticket_number VARCHAR(10) PRIMARY KEY,
    case_status VARCHAR(20),
    CONSTRAINT CC3 CHECK (case_status IN ('new', 'in-progress', 'resolved', 'closed')),
    short_desc VARCHAR(100),
    case_desc VARCHAR(1000),
    issue_type VARCHAR(20),
    CONSTRAINT CC4 CHECK (issue_type IN ('wired', 'wireless', 'storage', 'compute', 'vendor')),
    assigned_to VARCHAR(20),
    resolution_code VARCHAR(100),
    resolution_notes VARCHAR(100), -- Add this column
    FOREIGN KEY (resolution_code) REFERENCES Resolution (resolution_code)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Changes (
    chg_ticket_number VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (chg_ticket_number) REFERENCES Tickets (ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Problems (
    prb_ticket_number VARCHAR(10) PRIMARY KEY,
    chg_ticket_number VARCHAR(10),
    FOREIGN KEY (chg_ticket_number) REFERENCES Changes (chg_ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (prb_ticket_number) REFERENCES Tickets (ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Cases (
    case_ticket_number VARCHAR(10) PRIMARY KEY,
    prb_ticket_number VARCHAR(10),
    FOREIGN KEY (prb_ticket_number) REFERENCES Problems (prb_ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (case_ticket_number) REFERENCES Tickets (ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Incidents (
    inc_ticket_number VARCHAR(10) PRIMARY KEY,
    case_ticket_number VARCHAR(10),
    FOREIGN KEY (case_ticket_number) REFERENCES Cases (case_ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (inc_ticket_number) REFERENCES Tickets (ticket_number)
        ON UPDATE CASCADE ON DELETE CASCADE
);



