-- Correlation Data Export (For Power BI)
-- These columns will help generate correlation graphs and scatter plots in Power BI.
 use employees;
 SELECT performance_score, kpi_score, attendance_pct,
       peer_rating, task_completion_pct, manager_feedback,
       training_hours, work_hours_logged
FROM employee_performance;
