-- Question 3

-- find the day of the week with the shortest average arrival delay 
-- time(mins), return the name of the day and the average delay time
-- return 1 row in output
SELECT W.day_of_week AS day_of_week, AVG(F.arrival_delay) AS delay
FROM  FLIGHTS AS F, WEEKDAYS AS W
WHERE F.day_of_week_id = W.did
GROUP BY W.did, W.day_of_week
ORDER BY AVG(F.arrival_delay)
LIMIT 1;