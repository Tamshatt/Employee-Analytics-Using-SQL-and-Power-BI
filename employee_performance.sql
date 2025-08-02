use employees;

-- 1. Employee performance distribution
SELECT performance_level, COUNT(*) AS total_employees
FROM employee_performance
GROUP BY performance_level;

-- 2. Departments with highest average performance score
SELECT department,
       ROUND(AVG(performance_score), 2) AS avg_performance_score
FROM employee_performance
GROUP BY department
ORDER BY avg_performance_score DESC;

-- 3. KPI score vs promotion eligibility
SELECT promotion_eligibility,
       ROUND(AVG(kpi_score), 2) AS avg_kpi_score
FROM employee_performance
GROUP BY promotion_eligibility;

-- 4. Job roles with most high performers
SELECT job_role,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN performance_score >= 85 THEN 1 ELSE 0 END) AS high_performers
FROM employee_performance
GROUP BY job_role
ORDER BY high_performers DESC;

-- 5. Job roles/departments with low peer ratings
SELECT department, job_role,
       ROUND(AVG(peer_rating), 2) AS avg_peer_rating
FROM employee_performance
GROUP BY department, job_role
ORDER BY avg_peer_rating ASC
LIMIT 5;

-- 6. Training hours vs performance score
SELECT ROUND(AVG(training_hours), 0) AS avg_training_hours,
       ROUND(AVG(performance_score), 1) AS avg_performance_score
FROM employee_performance;

-- 7. Potential future leaders
SELECT name, job_role, department,
       performance_score, manager_feedback, promotion_eligibility
FROM employee_performance
WHERE performance_score >= 85 AND promotion_eligibility = 'Yes'
ORDER BY manager_feedback DESC;

-- 8. Average workload by department
SELECT department,
       ROUND(AVG(workload_ratio), 2) AS avg_workload_ratio
FROM employee_performance
GROUP BY department
ORDER BY avg_workload_ratio DESC;

-- 9. Data quality check
SELECT 
  SUM(CASE WHEN performance_score IS NULL THEN 1 ELSE 0 END) AS null_perf_score,
  SUM(CASE WHEN peer_rating IS NULL THEN 1 ELSE 0 END) AS null_peer_rating,
  SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department
FROM employee_performance;

-- 10. Top 5 departments by promotion eligibility
SELECT department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN promotion_eligibility = 'Yes' THEN 1 ELSE 0 END) AS eligible_employees
FROM employee_performance
GROUP BY department
ORDER BY eligible_employees DESC
LIMIT 5;

-- 11. High performers with low manager feedback
SELECT name, department, job_role,
       performance_score, manager_feedback
FROM employee_performance
WHERE performance_score >= 85 AND manager_feedback < 3
ORDER BY manager_feedback ASC;

-- 12. Training hours vs promotion eligibility
SELECT promotion_eligibility,
       ROUND(AVG(training_hours), 1) AS avg_training_hours
FROM employee_performance
GROUP BY promotion_eligibility;

-- 13. Job roles with highest workload ratio
SELECT job_role,
       ROUND(AVG(workload_ratio), 2) AS avg_workload_ratio
FROM employee_performance
GROUP BY job_role
ORDER BY avg_workload_ratio DESC
LIMIT 5;

-- 14. Consistently underperforming employees
SELECT name, department, job_role,
       performance_score, kpi_score, peer_rating, attendance_pct
FROM employee_performance
WHERE performance_score < 60 AND kpi_score < 60 AND peer_rating < 3
ORDER BY performance_score ASC;

-- 15. Department-wise promotion eligibility breakdown
SELECT department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN promotion_eligibility = 'Yes' THEN 1 ELSE 0 END) AS promotable
FROM employee_performance
GROUP BY department
ORDER BY promotable DESC;

-- 16. High attendance but low performance
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employee_performance) AS percentage
FROM employee_performance
WHERE attendance_pct >= 90 AND performance_score < 60;

-- 17. Top 10 well-rounded employees
SELECT name, department, job_role,
       performance_score, kpi_score, peer_rating, manager_feedback
FROM employee_performance
WHERE performance_score >= 85 AND kpi_score >= 80 AND peer_rating >= 4.5 AND manager_feedback >= 4.5
ORDER BY performance_score DESC
LIMIT 10;

-- 18. Job roles needing more training
SELECT job_role,
       ROUND(AVG(training_hours), 1) AS avg_training,
       ROUND(AVG(performance_score), 1) AS avg_perf
FROM employee_performance
GROUP BY job_role
HAVING AVG(performance_score) < 70
ORDER BY avg_training ASC;

-- 19. Performance by department and job role
SELECT department, job_role,
       ROUND(AVG(performance_score), 1) AS avg_perf_score
FROM employee_performance
GROUP BY department, job_role
ORDER BY department, avg_perf_score DESC;


