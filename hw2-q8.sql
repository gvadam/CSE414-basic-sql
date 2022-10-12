-- Question 8

-- Return the total departure delay time in minutes of each
-- airline across all their non-canceled flights
-- return 22 rows in output
SELECT C.name AS name, SUM(F.departure_delay) AS delay
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid
	AND F.canceled = 0
GROUP BY C.cid, C.name;