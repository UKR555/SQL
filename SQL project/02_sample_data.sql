-- Employee Payroll Management System
-- Sample Data Insertion

USE payroll_management;

-- Insert departments
INSERT INTO departments (department_name, location, budget) VALUES
('Human Resources', 'Building A, Floor 2', 500000.00),
('Information Technology', 'Building B, Floor 3', 1200000.00),
('Finance', 'Building A, Floor 1', 800000.00),
('Marketing', 'Building C, Floor 1', 600000.00),
('Operations', 'Building B, Floor 1', 900000.00),
('Sales', 'Building C, Floor 2', 700000.00);

-- Insert employees
INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, position, employment_type, status) VALUES
('John', 'Smith', 'john.smith@company.com', '555-0101', '2020-01-15', 2, 'Senior Software Engineer', 'Full-time', 'Active'),
('Sarah', 'Johnson', 'sarah.johnson@company.com', '555-0102', '2019-03-20', 1, 'HR Manager', 'Full-time', 'Active'),
('Michael', 'Williams', 'michael.williams@company.com', '555-0103', '2021-06-10', 3, 'Financial Analyst', 'Full-time', 'Active'),
('Emily', 'Brown', 'emily.brown@company.com', '555-0104', '2020-09-05', 4, 'Marketing Specialist', 'Full-time', 'Active'),
('David', 'Jones', 'david.jones@company.com', '555-0105', '2022-01-10', 2, 'Junior Developer', 'Full-time', 'Active'),
('Jessica', 'Garcia', 'jessica.garcia@company.com', '555-0106', '2018-11-15', 3, 'Finance Manager', 'Full-time', 'Active'),
('Robert', 'Miller', 'robert.miller@company.com', '555-0107', '2021-04-22', 5, 'Operations Coordinator', 'Full-time', 'Active'),
('Amanda', 'Davis', 'amanda.davis@company.com', '555-0108', '2020-07-30', 6, 'Sales Representative', 'Full-time', 'Active'),
('James', 'Wilson', 'james.wilson@company.com', '555-0109', '2022-03-01', 2, 'Database Administrator', 'Full-time', 'Active'),
('Lisa', 'Moore', 'lisa.moore@company.com', '555-0110', '2019-05-12', 1, 'HR Assistant', 'Part-time', 'Active'),
('Christopher', 'Taylor', 'christopher.taylor@company.com', '555-0111', '2021-08-18', 4, 'Content Writer', 'Full-time', 'Active'),
('Maria', 'Anderson', 'maria.anderson@company.com', '555-0112', '2020-02-14', 5, 'Operations Manager', 'Full-time', 'Active');

-- Insert salaries
INSERT INTO salaries (employee_id, base_salary, allowances, bonuses, overtime_pay, effective_date, end_date) VALUES
(1, 95000.00, 5000.00, 10000.00, 2000.00, '2023-01-01', NULL),
(2, 85000.00, 4000.00, 8000.00, 0.00, '2023-01-01', NULL),
(3, 70000.00, 3500.00, 5000.00, 500.00, '2023-01-01', NULL),
(4, 65000.00, 3000.00, 4000.00, 0.00, '2023-01-01', NULL),
(5, 55000.00, 2500.00, 3000.00, 800.00, '2023-01-01', NULL),
(6, 90000.00, 4500.00, 12000.00, 0.00, '2023-01-01', NULL),
(7, 60000.00, 3000.00, 3500.00, 600.00, '2023-01-01', NULL),
(8, 58000.00, 2800.00, 6000.00, 0.00, '2023-01-01', NULL),
(9, 80000.00, 4000.00, 7000.00, 1000.00, '2023-01-01', NULL),
(10, 35000.00, 1500.00, 2000.00, 0.00, '2023-01-01', NULL),
(11, 62000.00, 3000.00, 4000.00, 0.00, '2023-01-01', NULL),
(12, 88000.00, 4200.00, 10000.00, 0.00, '2023-01-01', NULL);

-- Insert attendance records (sample data for current month)
INSERT INTO attendance (employee_id, attendance_date, check_in_time, check_out_time, hours_worked, status, remarks) VALUES
(1, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(1, '2024-01-02', '09:15:00', '18:30:00', 8.25, 'Present', NULL),
(1, '2024-01-03', '09:00:00', '17:00:00', 7.00, 'Half-day', 'Left early'),
(2, '2024-01-01', '08:45:00', '17:30:00', 8.75, 'Present', NULL),
(2, '2024-01-02', '08:50:00', '17:45:00', 8.92, 'Present', NULL),
(2, '2024-01-03', NULL, NULL, 0.00, 'Leave', 'Sick leave'),
(3, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(3, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(3, '2024-01-03', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(4, '2024-01-01', '09:30:00', '18:30:00', 8.00, 'Present', NULL),
(4, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(4, '2024-01-03', NULL, NULL, 0.00, 'Absent', 'No show'),
(5, '2024-01-01', '09:00:00', '19:00:00', 9.00, 'Present', 'Overtime'),
(5, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(5, '2024-01-03', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(6, '2024-01-01', '08:30:00', '17:30:00', 8.00, 'Present', NULL),
(6, '2024-01-02', '08:30:00', '17:30:00', 8.00, 'Present', NULL),
(6, '2024-01-03', '08:30:00', '17:30:00', 8.00, 'Present', NULL),
(7, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(7, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(7, '2024-01-03', '09:00:00', '17:00:00', 7.00, 'Half-day', NULL),
(8, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(8, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(8, '2024-01-03', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(9, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(9, '2024-01-02', '09:00:00', '19:00:00', 9.00, 'Present', 'Overtime'),
(9, '2024-01-03', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(10, '2024-01-01', '10:00:00', '14:00:00', 4.00, 'Present', NULL),
(10, '2024-01-02', '10:00:00', '14:00:00', 4.00, 'Present', NULL),
(10, '2024-01-03', '10:00:00', '14:00:00', 4.00, 'Present', NULL),
(11, '2024-01-01', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(11, '2024-01-02', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(11, '2024-01-03', '09:00:00', '18:00:00', 8.00, 'Present', NULL),
(12, '2024-01-01', '08:00:00', '17:00:00', 8.00, 'Present', NULL),
(12, '2024-01-02', '08:00:00', '17:00:00', 8.00, 'Present', NULL),
(12, '2024-01-03', '08:00:00', '17:00:00', 8.00, 'Present', NULL);

