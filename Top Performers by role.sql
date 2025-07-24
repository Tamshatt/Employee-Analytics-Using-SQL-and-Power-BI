-- Top Performers by Role
-- Highlights which job roles have the most top performers (score ≥ 85).

use employees;
SELECT job_role,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN performance_score >= 85 THEN 1 ELSE 0 END) AS high_performers
FROM employee_performance
GROUP BY job_role
ORDER BY high_performers DESC;
