create database employees;
use employees;
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



