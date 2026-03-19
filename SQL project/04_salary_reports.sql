-- Employee Payroll Management System
-- Comprehensive Salary Reports using Joins

USE payroll_management;

-- Report 1: Complete Employee Salary Report with Department Information
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

-- Report 2: Department-wise Salary Summary
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

-- Report 3: Employee Salary Report with Attendance Summary
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
    AND a.attendance_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)  -- Last 30 days
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active'
GROUP BY 
    e.employee_id, e.first_name, e.last_name, d.department_name, 
    e.position, s.base_salary, s.allowances, s.bonuses, s.overtime_pay
ORDER BY 
    net_salary DESC;

-- Report 4: Top Earners by Department
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

-- Report 5: Payroll Summary Report (Overall Statistics)
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

-- Report 6: Employee Details with Salary History (if multiple salary records exist)
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

