-- Workload Ratio (Task Completion vs Hours)
use employees;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE employee_performance ADD workload_ratio FLOAT;

UPDATE employee_performance
SET workload_ratio = task_completion_pct / work_hours_logged;

SET SQL_SAFE_UPDATES = 1;
