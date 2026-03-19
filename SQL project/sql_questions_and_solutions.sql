Question 1: Display all employees with their full names and email addresses.

SELECT first_name, last_name, email FROM employees;

Question 2: Find all employees who work in the Information Technology department.

SELECT e.* FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Information Technology';

Question 3: Count the total number of employees in each department.

SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

Question 4: Show all employees hired after 2020.

SELECT * FROM employees WHERE hire_date > '2020-12-31';

Question 5: Calculate the total gross salary for all employees.

SELECT SUM(base_salary + allowances + bonuses + overtime_pay) AS total_gross_salary
FROM salaries
WHERE end_date IS NULL;

Question 6: Find employees with base salary greater than 80000.

SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.base_salary > 80000 AND s.end_date IS NULL;

Question 7: List all departments with their budget in descending order.

SELECT department_name, budget FROM departments ORDER BY budget DESC;

Question 8: Show employees who are part-time workers.

SELECT * FROM employees WHERE employment_type = 'Part-time';

Question 9: Find the average base salary across all employees.

SELECT AVG(base_salary) AS avg_base_salary
FROM salaries
WHERE end_date IS NULL;

Question 10: Display employees with their department names and positions.

SELECT e.first_name, e.last_name, d.department_name, e.position
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

Question 11: Count how many employees are present on 2024-01-01.

SELECT COUNT(*) AS present_count
FROM attendance
WHERE attendance_date = '2024-01-01' AND status = 'Present';

Question 12: Find the employee with the highest base salary.

SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
ORDER BY s.base_salary DESC
LIMIT 1;

Question 13: Show all employees who have overtime pay greater than 0.

SELECT e.first_name, e.last_name, s.overtime_pay
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.overtime_pay > 0 AND s.end_date IS NULL;

Question 14: Calculate total hours worked by each employee in January 2024.

SELECT employee_id, SUM(hours_worked) AS total_hours
FROM attendance
WHERE attendance_date >= '2024-01-01' AND attendance_date < '2024-02-01'
GROUP BY employee_id;

Question 15: Find employees who were absent on any day.

SELECT DISTINCT e.first_name, e.last_name
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Absent';

Question 16: Show department names and the number of active employees in each.

SELECT d.department_name, COUNT(e.employee_id) AS active_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
GROUP BY d.department_name;

Question 17: Display employees with their gross salary calculated.

SELECT e.first_name, e.last_name, 
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 18: Find employees who joined in 2021.

SELECT * FROM employees WHERE YEAR(hire_date) = 2021;

Question 19: Calculate the average allowances across all employees.

SELECT AVG(allowances) AS avg_allowances
FROM salaries
WHERE end_date IS NULL;

Question 20: Show employees with their check-in times for 2024-01-01.

SELECT e.first_name, e.last_name, a.check_in_time
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.attendance_date = '2024-01-01';

Question 21: Find departments with budget greater than 700000.

SELECT * FROM departments WHERE budget > 700000;

Question 22: Display employees sorted by their hire date.

SELECT * FROM employees ORDER BY hire_date;

Question 23: Count total bonuses paid to all employees.

SELECT SUM(bonuses) AS total_bonuses
FROM salaries
WHERE end_date IS NULL;

Question 24: Show employees who worked more than 8 hours on any day.

SELECT e.first_name, e.last_name, a.hours_worked, a.attendance_date
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.hours_worked > 8;

Question 25: Find the department with the highest budget.

SELECT * FROM departments ORDER BY budget DESC LIMIT 1;

Question 26: Display employees with their phone numbers and emails.

SELECT first_name, last_name, phone, email FROM employees;

Question 27: Calculate total payroll cost per department.

SELECT d.department_name, 
       SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_payroll
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL AND e.status = 'Active'
GROUP BY d.department_name;

Question 28: Show employees who took leave.

SELECT DISTINCT e.first_name, e.last_name
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Leave';

Question 29: Find employees with base salary between 60000 and 80000.

SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.base_salary BETWEEN 60000 AND 80000 AND s.end_date IS NULL;

Question 30: Display attendance records for employee ID 1.

SELECT * FROM attendance WHERE employee_id = 1;

Question 31: Count employees by employment type.

SELECT employment_type, COUNT(*) AS count
FROM employees
GROUP BY employment_type;

Question 32: Show employees with their department locations.

SELECT e.first_name, e.last_name, d.location
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

Question 33: Find the employee who worked the most hours in January 2024.

SELECT e.first_name, e.last_name, SUM(a.hours_worked) AS total_hours
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.attendance_date >= '2024-01-01' AND a.attendance_date < '2024-02-01'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_hours DESC
LIMIT 1;

Question 34: Display all active employees.

SELECT * FROM employees WHERE status = 'Active';

Question 35: Calculate average gross salary per department.

SELECT d.department_name,
       AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS avg_gross_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL AND e.status = 'Active'
GROUP BY d.department_name;

Question 36: Show employees who have no overtime pay.

SELECT e.first_name, e.last_name
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.overtime_pay = 0 AND s.end_date IS NULL;

Question 37: Find employees hired in the first quarter of 2020.

SELECT * FROM employees
WHERE hire_date >= '2020-01-01' AND hire_date < '2020-04-01';

Question 38: Count attendance records by status.

SELECT status, COUNT(*) AS count
FROM attendance
GROUP BY status;

Question 39: Display employees with their total bonuses.

SELECT e.first_name, e.last_name, s.bonuses
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 40: Find departments with more than 2 employees.

SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2;

Question 41: Show employees who were present all days in January 2024.

SELECT e.first_name, e.last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM attendance a
    WHERE a.employee_id = e.employee_id
    AND a.attendance_date >= '2024-01-01' AND a.attendance_date < '2024-02-01'
    AND a.status != 'Present'
);

Question 42: Calculate the difference between budget and total payroll for each department.

SELECT d.department_name,
       d.budget - COALESCE(SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay), 0) AS budget_difference
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_name, d.budget;

Question 43: Display employees with their years of service.

SELECT first_name, last_name, 
       DATEDIFF(CURDATE(), hire_date) / 365 AS years_of_service
FROM employees;

Question 44: Find employees who have the same position.

SELECT position, COUNT(*) AS count
FROM employees
GROUP BY position
HAVING COUNT(*) > 1;

Question 45: Show employees with their average hours worked per day.

SELECT e.first_name, e.last_name, AVG(a.hours_worked) AS avg_hours
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 46: Count employees by department and status.

SELECT d.department_name, e.status, COUNT(*) AS count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name, e.status;

Question 47: Display the top 3 highest paid employees.

SELECT e.first_name, e.last_name,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
ORDER BY gross_salary DESC
LIMIT 3;

Question 48: Find employees who worked half-day.

SELECT DISTINCT e.first_name, e.last_name
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Half-day';

Question 49: Calculate total tax if tax rate is 10% on gross salary above 50000.

SELECT employee_id,
       CASE 
           WHEN (base_salary + allowances + bonuses + overtime_pay) > 50000 
           THEN ((base_salary + allowances + bonuses + overtime_pay) - 50000) * 0.10
           ELSE 0
       END AS tax
FROM salaries
WHERE end_date IS NULL;

Question 50: Show employees with their department and total compensation.

SELECT e.first_name, e.last_name, d.department_name,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_compensation
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 51: Find employees who have not taken any leave.

SELECT e.first_name, e.last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM attendance a
    WHERE a.employee_id = e.employee_id AND a.status = 'Leave'
);

Question 52: Display departments sorted by number of employees.

SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;

Question 53: Calculate monthly salary for each employee.

SELECT e.first_name, e.last_name,
       ROUND((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) / 12, 2) AS monthly_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 54: Show employees with attendance percentage.

SELECT e.first_name, e.last_name,
       (COUNT(CASE WHEN a.status = 'Present' THEN 1 END) * 100.0 / COUNT(*)) AS attendance_percentage
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 55: Find employees with email containing 'john'.

SELECT * FROM employees WHERE email LIKE '%john%';

Question 56: Display total payroll by employment type.

SELECT e.employment_type,
       SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_payroll
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL AND e.status = 'Active'
GROUP BY e.employment_type;

Question 57: Show employees who joined in the last 3 years.

SELECT * FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

Question 58: Calculate average bonuses by department.

SELECT d.department_name, AVG(s.bonuses) AS avg_bonuses
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY d.department_name;

Question 59: Find employees with the longest service.

SELECT first_name, last_name, hire_date,
       DATEDIFF(CURDATE(), hire_date) AS days_employed
FROM employees
ORDER BY days_employed DESC
LIMIT 1;

Question 60: Display employees with their check-in and check-out times.

SELECT e.first_name, e.last_name, a.check_in_time, a.check_out_time, a.attendance_date
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.check_in_time IS NOT NULL;

Question 61: Count employees by position.

SELECT position, COUNT(*) AS count
FROM employees
GROUP BY position;

Question 62: Show departments with their total employee count and average salary.

SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       AVG(s.base_salary) AS avg_base_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_name;

Question 63: Find employees who have overtime pay greater than 500.

SELECT e.first_name, e.last_name, s.overtime_pay
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.overtime_pay > 500 AND s.end_date IS NULL;

Question 64: Display employees with their net salary after 15% tax deduction.

SELECT e.first_name, e.last_name,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) * 0.85 AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 65: Show employees who were absent more than once.

SELECT e.first_name, e.last_name, COUNT(*) AS absent_count
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Absent'
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING COUNT(*) > 1;

Question 66: Calculate total hours worked per employee in January 2024.

SELECT e.first_name, e.last_name, SUM(a.hours_worked) AS total_hours
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.attendance_date >= '2024-01-01' AND a.attendance_date < '2024-02-01'
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 67: Find employees with salary effective date in 2023.

SELECT e.first_name, e.last_name, s.effective_date
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE YEAR(s.effective_date) = 2023;

Question 68: Display employees with their department budget.

SELECT e.first_name, e.last_name, d.department_name, d.budget
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

Question 69: Find the average attendance hours per day.

SELECT AVG(hours_worked) AS avg_hours_per_day
FROM attendance
WHERE hours_worked IS NOT NULL;

Question 70: Show employees who have allowances greater than 3000.

SELECT e.first_name, e.last_name, s.allowances
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.allowances > 3000 AND s.end_date IS NULL;

Question 71: Calculate total cost including bonuses and overtime.

SELECT SUM(base_salary + allowances + bonuses + overtime_pay) AS total_cost
FROM salaries
WHERE end_date IS NULL;

Question 72: Display employees with their last attendance date.

SELECT e.first_name, e.last_name, MAX(a.attendance_date) AS last_attendance
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 73: Find employees in Finance department with salary above 70000.

SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE d.department_name = 'Finance' AND s.base_salary > 70000 AND s.end_date IS NULL;

Question 74: Show departments with average salary above 70000.

SELECT d.department_name, AVG(s.base_salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY d.department_name
HAVING AVG(s.base_salary) > 70000;

Question 75: Count employees by hire year.

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM employees
GROUP BY YEAR(hire_date);

Question 76: Display employees with their total days worked.

SELECT e.first_name, e.last_name, COUNT(a.attendance_id) AS days_worked
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id AND a.status = 'Present'
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 77: Find employees with the highest bonuses.

SELECT e.first_name, e.last_name, s.bonuses
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
ORDER BY s.bonuses DESC
LIMIT 1;

Question 78: Show employees who worked exactly 8 hours on any day.

SELECT e.first_name, e.last_name, a.attendance_date
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.hours_worked = 8;

Question 79: Calculate percentage of budget used per department.

SELECT d.department_name,
       (SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) / d.budget * 100) AS budget_used_percent
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL AND e.status = 'Active'
GROUP BY d.department_name, d.budget;

Question 80: Display employees with their first and last attendance dates.

SELECT e.first_name, e.last_name,
       MIN(a.attendance_date) AS first_attendance,
       MAX(a.attendance_date) AS last_attendance
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 81: Find employees who have never been absent.

SELECT e.first_name, e.last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM attendance a
    WHERE a.employee_id = e.employee_id AND a.status = 'Absent'
);

Question 82: Show employees with their department and position sorted by salary.

SELECT e.first_name, e.last_name, d.department_name, e.position,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS gross_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
ORDER BY gross_salary DESC;

Question 83: Calculate average salary increase if all get 10% raise.

SELECT AVG((base_salary + allowances + bonuses + overtime_pay) * 1.10) AS avg_salary_after_raise
FROM salaries
WHERE end_date IS NULL;

Question 84: Display employees with their attendance status for 2024-01-02.

SELECT e.first_name, e.last_name, a.status
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id AND a.attendance_date = '2024-01-02';

Question 85: Find employees with total compensation above 100000.

SELECT e.first_name, e.last_name,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_compensation
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) > 100000 AND s.end_date IS NULL;

Question 86: Show departments with their employee count and total payroll.

SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_payroll
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
LEFT JOIN salaries s ON e.employee_id = s.employee_id AND s.end_date IS NULL
GROUP BY d.department_name;

Question 87: Count employees by status.

SELECT status, COUNT(*) AS count
FROM employees
GROUP BY status;

Question 88: Display employees who joined between 2019 and 2021.

SELECT * FROM employees
WHERE hire_date BETWEEN '2019-01-01' AND '2021-12-31';

Question 89: Find employees with the lowest base salary.

SELECT e.first_name, e.last_name, s.base_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
ORDER BY s.base_salary ASC
LIMIT 1;

Question 90: Show employees with their average daily hours worked.

SELECT e.first_name, e.last_name, AVG(a.hours_worked) AS avg_daily_hours
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.hours_worked IS NOT NULL
GROUP BY e.employee_id, e.first_name, e.last_name;

Question 91: Calculate total tax collected if rate is 20% on salary above 60000.

SELECT SUM(
    CASE 
        WHEN (base_salary + allowances + bonuses + overtime_pay) > 60000
        THEN ((base_salary + allowances + bonuses + overtime_pay) - 60000) * 0.20
        ELSE 0
    END
) AS total_tax
FROM salaries
WHERE end_date IS NULL;

Question 92: Display employees with their department and employment type.

SELECT e.first_name, e.last_name, d.department_name, e.employment_type
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

Question 93: Find employees who worked on all three days in January 2024.

SELECT e.first_name, e.last_name
FROM employees e
WHERE (
    SELECT COUNT(DISTINCT a.attendance_date)
    FROM attendance a
    WHERE a.employee_id = e.employee_id
    AND a.attendance_date IN ('2024-01-01', '2024-01-02', '2024-01-03')
) = 3;

Question 94: Show employees with their salary components breakdown.

SELECT e.first_name, e.last_name,
       s.base_salary, s.allowances, s.bonuses, s.overtime_pay
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 95: Calculate average salary by position.

SELECT e.position, AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS avg_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY e.position;

Question 96: Display employees with their phone numbers who are in IT department.

SELECT e.first_name, e.last_name, e.phone
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Information Technology';

Question 97: Find employees with attendance records but no salary record.

SELECT DISTINCT e.first_name, e.last_name
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE NOT EXISTS (
    SELECT 1 FROM salaries s
    WHERE s.employee_id = e.employee_id AND s.end_date IS NULL
);

Question 98: Show total payroll cost by month of hire.

SELECT YEAR(hire_date) AS hire_year, MONTH(hire_date) AS hire_month,
       SUM(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS total_payroll
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL
GROUP BY YEAR(hire_date), MONTH(hire_date);

Question 99: Display employees with their net salary after progressive tax.

SELECT e.first_name, e.last_name,
       (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) -
       CASE 
           WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 50000 THEN 0
           WHEN (s.base_salary + s.allowances + s.bonuses + s.overtime_pay) <= 100000 
           THEN ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 50000) * 0.10
           ELSE 5000 + ((s.base_salary + s.allowances + s.bonuses + s.overtime_pay) - 100000) * 0.20
       END AS net_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL;

Question 100: Find the department with the highest average salary.

SELECT d.department_name, AVG(s.base_salary + s.allowances + s.bonuses + s.overtime_pay) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.end_date IS NULL AND e.status = 'Active'
GROUP BY d.department_name
ORDER BY avg_salary DESC
LIMIT 1;

