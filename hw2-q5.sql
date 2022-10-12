-- Question 5

-- Return the name of the the airlines, which has at least 0.6% of 
-- their flights from Seattle canceled, and the percent
-- returns 6 rows in output
SELECT C.name AS name, (100.0 * SUM(F.canceled) / COUNT(*)) AS percent
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
	AND F.origin_city = 'Seattle WA'
GROUP BY C.cid, C.name
HAVING 100.0 * SUM(F.canceled) / COUNT(*) >= 0.6
ORDER BY (100.0 * SUM(F.canceled) / COUNT(*)) DESC;
	
