-- Department-Wise Performance Overview
-- This query averages out important metrics per department to compare how they perform overall.

use employees;
SELECT department,
       ROUND(AVG(performance_score), 2) AS avg_perf_score,
       ROUND(AVG(kpi_score), 2) AS avg_kpi,
       ROUND(AVG(manager_feedback), 2) AS avg_mgr_feedback
FROM employee_performance
GROUP BY department;
