CREATE DATABASE IF NOT EXISTS payroll_management;
USE payroll_management;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(15, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    department_id INT,
    position VARCHAR(100),
    employment_type ENUM('Full-time', 'Part-time', 'Contract') DEFAULT 'Full-time',
    status ENUM('Active', 'Inactive', 'Terminated') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    allowances DECIMAL(10, 2) DEFAULT 0,
    bonuses DECIMAL(10, 2) DEFAULT 0,
    overtime_pay DECIMAL(10, 2) DEFAULT 0,
    effective_date DATE NOT NULL,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    check_in_time TIME,
    check_out_time TIME,
    hours_worked DECIMAL(5, 2),
    status ENUM('Present', 'Absent', 'Half-day', 'Leave', 'Holiday') DEFAULT 'Present',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (employee_id, attendance_date)
);

CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_salary_employee ON salaries(employee_id);
CREATE INDEX idx_salary_date ON salaries(effective_date);
CREATE INDEX idx_attendance_employee ON attendance(employee_id);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);

INSERT INTO departments (department_name, location, budget) VALUES
('Human Resources', 'Building A, Floor 2', 500000.00),
('Information Technology', 'Building B, Floor 3', 1200000.00),
('Finance', 'Building A, Floor 1', 800000.00),
('Marketing', 'Building C, Floor 1', 600000.00),
('Operations', 'Building B, Floor 1', 900000.00),
('Sales', 'Building C, Floor 2', 700000.00);

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

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.position,
    s.base_salary,
    s.allowances,
    s.bonuses,
    s.overtime_pay,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS tax_amount,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary
FROM 
    employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
ORDER BY 
    net_salary DESC;

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN '0% (0-50K)'
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN '10% (50K-100K)'
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN '20% (100K-200K)'
        ELSE '30% (Above 200K)'
    END AS tax_slab,
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS tax_amount,
    ROUND(
        (CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END / (s.base_salary + s.allowances + s.bonuses + s.overtime_pay)) * 100, 2
    ) AS tax_percentage,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary
FROM 
    employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
ORDER BY 
    gross_salary DESC;

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS annual_gross_salary,
    ROUND((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) / 12, 2) AS monthly_gross_salary,
    ROUND(
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END / 12, 2
    ) AS monthly_tax,
    ROUND(
        ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END) / 12, 2
    ) AS monthly_net_salary
FROM 
    employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
ORDER BY 
    monthly_net_salary DESC;

SELECT 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN '0% (0-50K)'
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN '10% (50K-100K)'
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN '20% (100K-200K)'
        ELSE '30% (Above 200K)'
    END AS tax_slab,
    COUNT(*) AS employee_count,
    ROUND(AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS avg_gross_salary,
    ROUND(SUM(
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_tax_collected,
    ROUND(SUM(
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_net_salary
FROM 
    employees e
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
GROUP BY 
    tax_slab
ORDER BY 
    CASE 
        WHEN tax_slab = '0% (0-50K)' THEN 1
        WHEN tax_slab = '10% (50K-100K)' THEN 2
        WHEN tax_slab = '20% (100K-200K)' THEN 3
        ELSE 4
    END;

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.email,
    e.phone,
    e.position,
    e.employment_type,
    d.department_name,
    d.location AS department_location,
    s.base_salary,
    s.allowances,
    s.bonuses,
    s.overtime_pay,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS tax_amount,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary,
    s.effective_date,
    DATEDIFF(CURDATE(), e.hire_date) AS days_employed
FROM 
    employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
ORDER BY 
    d.department_name, net_salary DESC;

SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(SUM(s.base_salary), 2) AS total_base_salary,
    ROUND(SUM(s.allowances), 2) AS total_allowances,
    ROUND(SUM(s.bonuses), 2) AS total_bonuses,
    ROUND(SUM(s.overtime_pay), 2) AS total_overtime_pay,
    ROUND(SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS total_gross_salary,
    ROUND(SUM(
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_tax,
    ROUND(SUM(
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_net_salary,
    ROUND(AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS avg_gross_salary,
    ROUND(AVG(
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS avg_net_salary
FROM 
    departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY 
    d.department_id, d.department_name
ORDER BY 
    total_net_salary DESC;

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.position,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS days_present,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS days_absent,
    COUNT(CASE WHEN a.status = 'Leave' THEN 1 END) AS days_leave,
    COUNT(CASE WHEN a.status = 'Half-day' THEN 1 END) AS days_half_day,
    COALESCE(SUM(a.hours_worked), 0) AS total_hours_worked,
    ROUND(COALESCE(AVG(a.hours_worked), 0), 2) AS avg_hours_per_day
FROM 
    employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
LEFT JOIN attendance a ON e.employee_id = a.employee_id 
    AND a.attendance_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
GROUP BY 
    e.employee_id, e.first_name, e.last_name, d.department_name, 
    e.position, s.base_salary, s.allowances, s.bonuses, s.overtime_pay
ORDER BY 
    net_salary DESC;

SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.position,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary,
    ROW_NUMBER() OVER (PARTITION BY d.department_id ORDER BY 
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) DESC) AS rank_in_department
FROM 
    employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
ORDER BY 
    d.department_name, net_salary DESC;

SELECT 
    COUNT(DISTINCT e.employee_id) AS total_active_employees,
    COUNT(DISTINCT d.department_id) AS total_departments,
    ROUND(SUM(s.base_salary), 2) AS total_base_salary,
    ROUND(SUM(s.allowances), 2) AS total_allowances,
    ROUND(SUM(s.bonuses), 2) AS total_bonuses,
    ROUND(SUM(s.overtime_pay), 2) AS total_overtime_pay,
    ROUND(SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS total_gross_salary,
    ROUND(SUM(
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_tax_deduction,
    ROUND(SUM(
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS total_net_salary,
    ROUND(AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS avg_gross_salary,
    ROUND(AVG(
        (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
        CASE 
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
                ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
            WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
                5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
            ELSE 
                25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
        END
    ), 2) AS avg_net_salary,
    ROUND(MAX(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS max_gross_salary,
    ROUND(MIN(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS min_gross_salary
FROM 
    employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active';

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.position,
    s.effective_date,
    COALESCE(s.end_date, 'Current') AS salary_end_date,
    s.base_salary,
    s.allowances,
    s.bonuses,
    s.overtime_pay,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS net_salary
FROM 
    employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    e.status = 'Active'
ORDER BY 
    e.employee_id, s.effective_date DESC;

