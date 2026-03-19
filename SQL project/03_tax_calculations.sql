-- Employee Payroll Management System
-- Tax Calculations using CASE Statements
-- Net Salary Calculation with Tax Slabs

USE payroll_management;

-- Tax Slab Structure (Example):
-- 0 - 50,000: 0% tax
-- 50,001 - 100,000: 10% tax
-- 100,001 - 200,000: 20% tax
-- Above 200,000: 30% tax

-- Query 1: Calculate Gross Salary, Tax, and Net Salary for all employees
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.position,
    s.base_salary,
    s.allowances,
    s.bonuses,
    s.overtime_pay,
    (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary,
    -- Tax calculation using CASE statements
    CASE 
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 THEN 
            ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
        WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 200000 THEN 
            5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
        ELSE 
            25000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 200000) * 0.30
    END AS tax_amount,
    -- Net Salary = Gross Salary - Tax
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
    s.end_date IS NULL  -- Current active salary
    AND e.status = 'Active'
ORDER BY 
    net_salary DESC;

-- Query 2: Tax calculation with detailed breakdown by tax slab
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

-- Query 3: Monthly salary calculation with tax (assuming annual salary)
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

-- Query 4: Summary statistics by tax slab
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

