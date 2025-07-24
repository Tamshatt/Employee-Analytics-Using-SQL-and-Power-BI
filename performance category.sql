--  Performance Category
use employees;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE employee_performance ADD performance_level VARCHAR(10);

UPDATE employee_performance
SET performance_level = CASE
  WHEN performance_score >= 85 THEN 'High'
  WHEN performance_score >= 70 THEN 'Medium'
  ELSE 'Low'
END;

SET SQL_SAFE_UPDATES = 1;







