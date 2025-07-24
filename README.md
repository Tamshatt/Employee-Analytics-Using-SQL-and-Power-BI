# Employee-Analytics-Using-SQL-and-Power-BI

## 📝 Overview

This project provides a comprehensive view of employee performance and promotion eligibility by analyzing performance scores, KPIs, peer ratings, and other HR metrics. It demonstrates how **SQL** can be used for data preparation and how **Power BI** can visualize actionable insights.

The analysis is delivered in two dashboards:
- 🔷 Performance Overview
- 🟢 Promotion Analysis

---

## 🧹 Data Cleaning & Feature Engineering (SQL)

The dataset was cleaned and enhanced using SQL before being loaded into Power BI. Below are the key transformation steps:

### 🔧 Key SQL Operations:

```sql
-- Create database and use it
CREATE DATABASE employees;
USE employees;

-- Create employee performance table
CREATE TABLE employee_performance (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    job_role VARCHAR(100),
    performance_score INT,
    kpi_score FLOAT,
    attendance_pct FLOAT,
    peer_rating FLOAT,
    task_completion_pct FLOAT,
    work_hours_logged INT,
    manager_feedback FLOAT,
    training_hours INT,
    promotion_eligibility VARCHAR(10)
);

-- Handle missing and out-of-bound data
SELECT 
  SUM(CASE WHEN performance_score IS NULL THEN 1 ELSE 0 END) AS null_perf,
  SUM(CASE WHEN peer_rating IS NULL THEN 1 ELSE 0 END) AS null_peer_rating,
  SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department
FROM employee_performance;

SELECT * FROM employee_performance WHERE peer_rating > 5 OR peer_rating < 1;

-- Add performance level column
ALTER TABLE employee_performance ADD performance_level VARCHAR(10);
UPDATE employee_performance
SET performance_level = CASE
  WHEN performance_score >= 85 THEN 'High'
  WHEN performance_score >= 70 THEN 'Medium'
  ELSE 'Low'
END;

-- Add workload ratio column
ALTER TABLE employee_performance ADD workload_ratio FLOAT;
UPDATE employee_performance
SET workload_ratio = task_completion_pct / work_hours_logged;

-- Department-level summary
SELECT department,
       ROUND(AVG(performance_score), 2) AS avg_perf_score,
       ROUND(AVG(kpi_score), 2) AS avg_kpi,
       ROUND(AVG(manager_feedback), 2) AS avg_mgr_feedback
FROM employee_performance
GROUP BY department;

-- Promotion eligibility summary
SELECT promotion_eligibility,
       COUNT(*) AS total_employees,
       ROUND(AVG(performance_score), 2) AS avg_perf_score,
       ROUND(AVG(kpi_score), 2) AS avg_kpi,
       ROUND(AVG(peer_rating), 2) AS avg_peer_rating,
       ROUND(AVG(training_hours), 2) AS avg_training
FROM employee_performance
GROUP BY promotion_eligibility;

-- Job role-wise high performer count
SELECT job_role,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN performance_score >= 85 THEN 1 ELSE 0 END) AS high_performers
FROM employee_performance
GROUP BY job_role
ORDER BY high_performers DESC;

-- Create summary views for dashboards
CREATE VIEW v_performance_summary AS
SELECT department, job_role, performance_level,
       ROUND(AVG(performance_score), 1) AS avg_perf,
       ROUND(AVG(kpi_score), 1) AS avg_kpi,
       ROUND(AVG(peer_rating), 1) AS avg_peer
FROM employee_performance
GROUP BY department, job_role, performance_level;

CREATE VIEW v_promotion_dashboard AS
SELECT job_role, department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN promotion_eligibility = 'Yes' THEN 1 ELSE 0 END) AS eligible,
       ROUND(AVG(training_hours), 1) AS avg_training,
       ROUND(AVG(manager_feedback), 2) AS avg_mgr_feedback
FROM employee_performance
GROUP BY job_role, department;
````

---

## 📈 Dashboard 1: Performance Overview

### 🔍 Insights:

* **Avg Performance Score**: 74.78
* **Avg KPI Score**: 77.38
* **Avg Peer Rating**: 4.00

#### 🧠 Additional Highlights:

* **Top Job Roles**: Accountant, Recruitment Specialist
* **Top Departments**: HR, Finance
* **Performance Distribution**:

  * High: 30.74%
  * Medium: 29.7%
  * Low: 39.56%

---

## 📊 Dashboard 2: Promotion Analysis

### 🔍 Insights:

* **Total Eligible for Promotion**: 695
* **Promotion Rate**: 13.51%
* **Departments with Highest Eligibility Percent**:

  * Sales: 20.7%
  * Finance: 20.32%
  * HR: 20.20%

#### ⚠️ Observations:

* A significant number of **high performers are not eligible** for promotion.
* **Manager feedback** is consistently high across all performance levels, indicating potential bias.

---

## 📈 Tools & Technologies

| Category       | Tools/Skills Used                                           |
| -------------- | ----------------------------------------------------------- |
| Data Cleaning  | SQL (Joins, CASE, Aggregates, Views)                        |
| Visualization  | Power BI                                                    |
| Metrics & KPIs | Performance Score, KPI Score, Peer Rating, Manager Feedback |
| Business Focus | HR Analytics, Promotion Analysis                            |


## 📍 Conclusion

This project demonstrates the power of SQL and Power BI in solving real-world HR challenges, from identifying top performers to revealing inefficiencies in promotion pipelines. The solution helps HR and leadership teams make informed, data-driven decisions.


