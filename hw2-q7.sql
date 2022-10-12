-- Question 7

-- Return the total capacity of all direct flights that fly
-- between Seattle and San Francisco on July 11th
-- return 1 row in output
SELECT SUM(F.capacity) AS capacity
FROM FLIGHTS AS F, MONTHS AS M
WHERE F.month_id = M.mid
	AND M.month = 'July'
	AND F.day_of_month = 11
	AND ((F.origin_city = 'Seattle WA' 
			AND F.dest_city = 'San Francisco CA') 
		OR (F.origin_city = 'San Francisco CA' 
			AND F.dest_city = 'Seattle WA'));