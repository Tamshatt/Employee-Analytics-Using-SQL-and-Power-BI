-- Analyze Promotion Eligibility
-- Compares performance and training of those who are eligible vs. not eligible for promotion.

SELECT promotion_eligibility,
       COUNT(*) AS total_employees,
       ROUND(AVG(performance_score), 2) AS avg_perf_score,
       ROUND(AVG(kpi_score), 2) AS avg_kpi,
       ROUND(AVG(peer_rating), 2) AS avg_peer_rating,
       ROUND(AVG(training_hours), 2) AS avg_training
FROM employee_performance
GROUP BY promotion_eligibility;


