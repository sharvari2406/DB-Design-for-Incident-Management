create database dma_project;
use dma_project;

CREATE TABLE Team_PDL (
    team_email varchar(50) PRIMARY KEY,
    assignment_group varchar(20),
    CONSTRAINT CC1 CHECK(assignment_group IN ('L1_Engineers', 'L2_Engineers', 'Problem_Management', 'Change_Management')),
    CONSTRAINT CC2 CHECK(team_email IN ('L1_Engineers@dma.com', 'L2_Engineers@dma.com', 'Problem_Management@dma.com', 'Change_Management@dma.com'))
);


create table Employees (
emp_name varchar (20), 
emp_id int PRIMARY KEY, 
personal_email varchar(50), contact_number varchar(10), 
team_email varchar(50) NOT NULL, 
foreign key(team_email) references Team_PDL(team_email) on update cascade on delete cascade) ;


CREATE TABLE Knowledge_Articles (
    article_number VARCHAR(20) PRIMARY KEY,
    article_type VARCHAR(10),
    created_by VARCHAR(20) NOT NULL,
    article_content VARCHAR(1000) NOT NULL,
    emp_id INT NOT NULL,
    Foreign key (emp_id) references Employees(emp_id) on update cascade on delete cascade
);

CREATE TABLE L1_engineers (
    emp_id INT PRIMARY KEY,
    FOREIGN KEY (emp_id)
        REFERENCES Employees (emp_id)
);

CREATE TABLE L2_engineers (
    emp_id INT PRIMARY KEY,
    FOREIGN KEY (emp_id)
        REFERENCES Employees (emp_id)
);

CREATE TABLE Problem_Management (
    emp_id INT PRIMARY KEY,
    FOREIGN KEY (emp_id)
        REFERENCES Employees (emp_id)
);

CREATE TABLE Change_Managers (
    emp_id INT PRIMARY KEY,
    FOREIGN KEY (emp_id)
        REFERENCES Employees (emp_id)
);

CREATE TABLE Change_approvers (
    emp_id INT PRIMARY KEY,
    FOREIGN KEY (emp_id)
        REFERENCES Employees (emp_id)
);

