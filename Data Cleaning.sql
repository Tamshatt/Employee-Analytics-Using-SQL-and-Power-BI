use employees;
SELECT 
  SUM(CASE WHEN performance_score IS NULL THEN 1 ELSE 0 END) AS null_perf,
  SUM(CASE WHEN peer_rating IS NULL THEN 1 ELSE 0 END) AS null_peer_rating,
  SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department
FROM employee_performance;

SELECT * FROM employee_performance WHERE peer_rating > 5 OR peer_rating < 1;

