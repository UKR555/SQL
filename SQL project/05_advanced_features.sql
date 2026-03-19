-- Employee Payroll Management System
-- Advanced SQL Features for Portfolio Enhancement
-- Optional: Stored Procedures, Views, and Advanced Analytics

USE payroll_management;

-- ============================================
-- VIEWS: Simplify frequently used queries
-- ============================================

-- View 1: Employee Salary Summary View
CREATE OR REPLACE VIEW v_employee_salary_summary AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    e.position,
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
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN salaries s ON e.employee_id = s.employee_id
WHERE 
    s.end_date IS NULL
    AND e.status = 'Active';

-- View 2: Department Payroll Summary View
CREATE OR REPLACE VIEW v_department_payroll AS
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
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
    ), 2) AS total_net_salary
FROM 
    departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY 
    d.department_id, d.department_name;

-- ============================================
-- STORED PROCEDURES: Reusable business logic
-- ============================================

-- Procedure 1: Calculate Employee Net Salary
DELIMITER //

CREATE PROCEDURE sp_calculate_employee_salary(
    IN p_employee_id INT,
    OUT p_gross_salary DECIMAL(10, 2),
    OUT p_tax_amount DECIMAL(10, 2),
    OUT p_net_salary DECIMAL(10, 2)
)
BEGIN
    DECLARE v_gross DECIMAL(10, 2);
    
    -- Calculate gross salary
    SELECT (base_salary + allowances + bonuses + overtime_pay)
    INTO v_gross
    FROM salaries
    WHERE employee_id = p_employee_id
    AND end_date IS NULL;
    
    SET p_gross_salary = v_gross;
    
    -- Calculate tax using CASE logic
    SET p_tax_amount = CASE 
        WHEN v_gross <= 50000 THEN 0
        WHEN v_gross <= 100000 THEN (v_gross - 50000) * 0.10
        WHEN v_gross <= 200000 THEN 5000 + (v_gross - 100000) * 0.20
        ELSE 25000 + (v_gross - 200000) * 0.30
    END;
    
    -- Calculate net salary
    SET p_net_salary = v_gross - p_tax_amount;
END //

DELIMITER ;

-- Procedure 2: Get Department Payroll Summary
DELIMITER //

CREATE PROCEDURE sp_get_department_payroll(IN p_department_id INT)
BEGIN
    SELECT 
        d.department_name,
        COUNT(e.employee_id) AS employee_count,
        ROUND(SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS total_gross,
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
        ), 2) AS total_net
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
    LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
    WHERE d.department_id = p_department_id
    GROUP BY d.department_name;
END //

DELIMITER ;

-- ============================================
-- ADVANCED ANALYTICS QUERIES
-- ============================================

-- Query: Year-over-Year Salary Growth (if historical data exists)
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    YEAR(s1.effective_date) AS year,
    (s1.base_salary + s1.allowances + s1.bonuses + s1.overtime_pay) AS salary_year1,
    (SELECT (s2.base_salary + s2.allowances + s2.bonuses + s2.overtime_pay)
     FROM salaries s2
     WHERE s2.employee_id = e.employee_id
     AND YEAR(s2.effective_date) = YEAR(s1.effective_date) + 1
     LIMIT 1) AS salary_year2,
    ROUND(
        (((SELECT (s2.base_salary + s2.allowances + s2.bonuses + s2.overtime_pay)
          FROM salaries s2
          WHERE s2.employee_id = e.employee_id
          AND YEAR(s2.effective_date) = YEAR(s1.effective_date) + 1
          LIMIT 1) - (s1.base_salary + s1.allowances + s1.bonuses + s1.overtime_pay)) 
         / (s1.base_salary + s1.allowances + s1.bonuses + s1.overtime_pay)) * 100, 2
    ) AS growth_percentage
FROM employees e
INNER JOIN salaries s1 ON e.employee_id = s1.employee_id
WHERE e.status = 'Active'
ORDER BY e.employee_id, s1.effective_date;

-- Query: Employee Attendance Performance
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS days_present,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS days_absent,
    COUNT(CASE WHEN a.status = 'Leave' THEN 1 END) AS days_leave,
    ROUND(
        (COUNT(CASE WHEN a.status = 'Present' THEN 1 END) * 100.0 / 
         NULLIF(COUNT(*), 0)), 2
    ) AS attendance_percentage,
    COALESCE(SUM(a.hours_worked), 0) AS total_hours
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
LEFT JOIN attendance a ON e.employee_id = a.employee_id
    AND a.attendance_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
ORDER BY attendance_percentage DESC;

-- Query: Budget vs Actual Payroll Analysis
SELECT 
    d.department_id,
    d.department_name,
    d.budget AS allocated_budget,
    ROUND(SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 2) AS actual_payroll,
    ROUND(
        (d.budget - SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay)), 2
    ) AS budget_variance,
    ROUND(
        ((d.budget - SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay)) / d.budget * 100), 2
    ) AS variance_percentage,
    CASE 
        WHEN SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= d.budget THEN 'Within Budget'
        ELSE 'Over Budget'
    END AS budget_status
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_id, d.department_name, d.budget
ORDER BY variance_percentage;

-- ============================================
-- USAGE EXAMPLES
-- ============================================

-- Use View:
-- SELECT * FROM v_employee_salary_summary WHERE department_name = 'Information Technology';

-- Call Stored Procedure:
-- CALL sp_calculate_employee_salary(1, @gross, @tax, @net);
-- SELECT @gross AS gross_salary, @tax AS tax_amount, @net AS net_salary;

-- Call Department Procedure:
-- CALL sp_get_department_payroll(2);

