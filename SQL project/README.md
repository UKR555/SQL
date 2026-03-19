# Employee Payroll Management System

This is a payroll management database I built to practice SQL. It handles employees, departments, salaries, and attendance tracking. I also added tax calculations using CASE statements and some reports using joins.

## What's in this project

I created 4 main tables:
- departments - stores department info like name, location, and budget
- employees - employee details like name, email, position, which department they're in
- salaries - salary info including base salary, allowances, bonuses, overtime
- attendance - daily attendance records with check in/out times

## Database Structure

departments table:
- department_id (primary key)
- department_name
- location
- budget
- created_at

employees table:
- employee_id (primary key)
- first_name, last_name
- email (unique)
- phone
- hire_date
- department_id (foreign key to departments)
- position
- employment_type (Full-time, Part-time, Contract)
- status (Active, Inactive, Terminated)
- created_at

salaries table:
- salary_id (primary key)
- employee_id (foreign key to employees)
- base_salary
- allowances
- bonuses
- overtime_pay
- effective_date
- end_date (NULL means current salary)
- created_at

attendance table:
- attendance_id (primary key)
- employee_id (foreign key to employees)
- attendance_date
- check_in_time, check_out_time
- hours_worked
- status (Present, Absent, Half-day, Leave, Holiday)
- remarks
- created_at

## Features

Schema Design:
I tried to normalize the database properly with foreign keys. Added some indexes too for better performance. The salary table can store historical records since each employee can have multiple salary entries.

Tax Calculation:
I implemented a progressive tax system using CASE statements. The tax slabs are:
- 0 - 50,000: 0% tax
- 50,001 - 100,000: 10% tax
- 100,001 - 200,000: 20% tax
- Above 200,000: 30% tax

Here's how I calculate it:

CASE 
    WHEN gross_salary <= 50000 THEN 0
    WHEN gross_salary <= 100000 THEN (gross_salary - 50000) * 0.10
    WHEN gross_salary <= 200000 THEN 5000 + (gross_salary - 100000) * 0.20
    ELSE 25000 + (gross_salary - 200000) * 0.30
END

Net salary is just: Gross Salary - Tax

Where Gross Salary = Base Salary + Allowances + Bonuses + Overtime Pay

Reports:
I wrote several reports using joins:
- Complete employee salary report with department info
- Department-wise salary summaries
- Employee salary with attendance data
- Top earners by department
- Overall payroll summary
- Salary history (if you have multiple salary records)

## How to Run

You'll need MySQL installed. I used MySQL 5.7+ but it should work with MariaDB too.

1. First, create the database and tables:
mysql -u root -p < 01_schema.sql

2. Then insert the sample data:
mysql -u root -p < 02_sample_data.sql

3. For tax calculations, you can run:
mysql -u root -p < 03_tax_calculations.sql

4. For reports:
mysql -u root -p < 04_salary_reports.sql

Or you can just open the files in MySQL Workbench and run them one by one. The first two files (schema and sample data) need to run first, but the other two are just queries you can run anytime.

## File Structure

SQL project/
- 01_schema.sql (Creates database and tables)
- 02_sample_data.sql (Inserts sample data)
- 03_tax_calculations.sql (Tax calculation queries)
- 04_salary_reports.sql (Salary reports using joins)
- README.md (This file)

## Tax Calculation Details

The tax calculation works like this:

Income Range 0 - 50,000: Tax Rate 0%, Calculation: No tax
Income Range 50,001 - 100,000: Tax Rate 10%, Calculation: (Income - 50,000) × 0.10
Income Range 100,001 - 200,000: Tax Rate 20%, Calculation: 5,000 + (Income - 100,000) × 0.20
Income Range Above 200,000: Tax Rate 30%, Calculation: 25,000 + (Income - 200,000) × 0.30

Example: If someone makes $120,000:
- First 50k: $0 tax
- Next 50k (50,001-100,000): $5,000 tax (50,000 × 10%)
- Remaining 20k (100,001-120,000): $4,000 tax (20,000 × 20%)
- Total Tax: $9,000
- Net Salary: $111,000

## Reports Available

1. Complete Employee Salary Report - Shows all employees with full salary breakdown, tax, net salary, and department info

2. Department-wise Salary Summary - Aggregated stats by department (total employees, total salaries, averages, etc.)

3. Employee Salary with Attendance - Combines salary data with attendance records to show days present/absent and hours worked

4. Top Earners by Department - Uses ROW_NUMBER() to rank employees within each department

5. Payroll Summary Report - Overall company stats like total payroll, average salaries, min/max

6. Salary History Report - Shows all salary records for employees (useful if you have historical data)

## Customization

If you want to change the tax rates, just update the CASE statements in:
- 03_tax_calculations.sql
- 04_salary_reports.sql

To add new fields:
1. Alter the table in 01_schema.sql
2. Update the sample data in 02_sample_data.sql
3. Modify the queries in the other files

## Notes

- Salaries are stored as DECIMAL(10, 2) to avoid rounding issues
- The salary table supports multiple records per employee (for tracking salary changes over time)
- Current salary is the one where end_date IS NULL
- Attendance records are unique per employee per date (can't have duplicate entries)
- Timestamps are handled automatically

## What I Learned

This project helped me practice:
- Database schema design and normalization
- Foreign keys and referential integrity
- CASE statements for conditional logic
- Different types of JOINs (INNER, LEFT)
- Aggregate functions with GROUP BY
- Window functions like ROW_NUMBER()
- Date functions
- Subqueries

This is a portfolio project I created to demonstrate SQL skills.
