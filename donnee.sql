--create database factory ##
create database factory;
 
--create table team
create table team(
    id SERIAL PRIMARY KEY,
   team_name VARCHAR NOT NULL
);

 --Create table employee
 create table employee(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    contract_type VARCHAR(50),
    salary INT,
    team_id INT,
    CONSTRAINT fk_team FOREIGN KEY (team_id)
    REFERENCES team(id)
 );
 
 --create table leave
 create table leave(
    id SERIAL PRIMARY KEY,
    start_leave_date Date,
    end_leave_date Date,
    employee_id INT,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id)
    REFERENCES employee(id)
 );

---I ASK CHAT GPT TO DO THIS INSERT ---


-- Insert data into team

INSERT INTO team (team_name) VALUES
('Development'),
('Marketing'),
('Sales'),
('HR'),
('Finance');


-- Insert data into employee

INSERT INTO employee (first_name, last_name, contract_type, salary, team_id) VALUES
('Alice', 'Ramarozaka', 'Full-time', 3000, 1),
('Bob', 'Andriamasy', 'Part-time', 2000, 2),
('Charlie', 'Rakotomalala', 'Full-time', 3500, 1),
('Dina', 'Rasoa', 'Intern', 1000, 3),
('Eric', 'Randrianarisoa', 'Full-time', 4000, NULL);  -- employee without team


-- Insert data into leave

INSERT INTO leave (start_leave_date, end_leave_date, employee_id) VALUES
('2025-11-01', '2025-11-05', 1),
('2025-10-20', '2025-10-22', 2),
('2025-11-10', '2025-11-12', 3),
('2025-11-14', '2025-11-15', 4),
('2025-12-01', '2025-12-05', 1);

--SELECT---

--Afficher l’id, first_name, last_name des employés qui n’ont pas d’équipe. 
--Afficher l’id, first_name, last_name des employés qui n’ont jamais pris de congé de leur vie.
--Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe.
--Affichez par le nombre d’employés par contract_type, vous devez afficher le type de contrat, et le nombre d’employés associés.
--Afficher le nombre d’employés en congé aujourd'hui. La période de congé s'étend de start_date inclus jusqu’à end_date inclus.
--Afficher l’id, le nom, le prénom de tous les employés + le nom de leur équipe qui sont en congé aujourd’hui. Pour rappel, la end_date est incluse dans le congé, l’employé ne revient que le lendemain. 

SELECT id,first_name, last_name from employee where team_id is NULL;
SELECT  employee.id,first_name, last_name from leave right join employee ON leave.employee_id = employee.id where leave.employee_id is NULL;
SELECT leave.id,start_leave_date,end_leave_date, employee.id,first_name, last_name,team.id from leave inner join employee ON leave.employee_id = employee.id inner join team ON employee.team_id = team.id;
SELECT contract_type, COUNT(*) AS contract_Count FROM employee GROUP BY contract_type;
SELECT COUNT(*) AS employees_on_leave_today FROM leave inner JOIN employee  ON leave.employee_id = employee.id WHERE CURRENT_DATE BETWEEN leave.start_leave_date AND leave.end_leave_date;
SELECT employee.id,first_name,last_name,team_name FROM leave JOIN employee  ON leave.employee_id = employee.id LEFT JOIN team  ON employee.team_id = team.id WHERE CURRENT_DATE BETWEEN leave.start_leave_date AND leave.end_leave_date;
