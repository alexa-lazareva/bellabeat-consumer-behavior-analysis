SELECT 
    COUNT(DISTINCT Id) AS unique_users,
    ROUND(AVG(TotalSteps), 0) AS mean_steps,
    MAX(TotalSteps) AS max_steps,
    MIN(TotalSteps) AS min_steps,
    ROUND(AVG(Calories), 0) AS mean_calories
FROM `bellabeat-case-study-494611.bellabeat_data.daily_activity`;
SELECT 
    A.Id,
    ROUND(AVG(A.TotalSteps), 0) AS avg_steps,
    ROUND(AVG(A.Calories), 0) AS avg_calories,
    ROUND(AVG(W.WeightKg), 1) AS avg_weight
FROM `bellabeat-case-study-494611.bellabeat_data.daily_activity` AS A
LEFT JOIN `bellabeat-case-study-494611.bellabeat_data.weight_log_info` AS W
ON A.Id = W.Id
GROUP BY A.Id
HAVING avg_weight IS NOT NULL
ORDER BY avg_weight DESC;
CREATE OR REPLACE TABLE `bellabeat-case-study-494611.bellabeat_data.user_activity_trends` AS
SELECT 
    Id,
    ROUND(AVG(TotalSteps), 0) AS avg_daily_steps,
    ROUND(AVG(Calories), 0) AS avg_daily_calories,
    CASE 
        WHEN AVG(TotalSteps) < 5000 THEN 'Sedentary'
        WHEN AVG(TotalSteps) BETWEEN 5000 AND 10000 THEN 'Active'
        WHEN AVG(TotalSteps) > 10000 THEN 'Very Active'
    END AS activity_level
FROM `bellabeat-case-study-494611.bellabeat_data.daily_activity`
GROUP BY Id;
WITH user_averages AS (
    SELECT 
        Id,
        ROUND(AVG(TotalSteps), 0) AS avg_daily_steps,
        ROUND(AVG(Calories), 0) AS avg_daily_calories
    FROM `bellabeat-case-study-494611.bellabeat_data.daily_activity`
    GROUP BY Id
)

SELECT 
    Id,
    avg_daily_steps,
    avg_daily_calories,
    CASE 
        WHEN avg_daily_steps < 5000 THEN 'Sedentary'
        WHEN avg_daily_steps BETWEEN 5000 AND 10000 THEN 'Active'
        WHEN avg_daily_steps > 10000 THEN 'Very Active'
    END AS activity_level
FROM user_averages
ORDER BY avg_daily_steps DESC;
