-- Question 4

-- Return the name of airlines that ever flew more than 
-- 1000 flights in one day
-- return 12 rows in output
SELECT DISTINCT C.name AS name
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
GROUP BY C.cid, C.name, F.month_id, F.day_of_month
HAVING COUNT(*) > 1000;