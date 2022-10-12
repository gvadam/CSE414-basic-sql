-- Question 6

-- Find the cheapest flight ticket between Seattle and New York,
-- NY for each carriers that offer flights between them, return
-- the name of the carriers and the minimum price
-- returns three rows in output
SELECT C.name AS carrier, MIN(F.price) AS min_price
FROM FLIGHTS AS F, CARRIERS AS C
WHERE F.carrier_id = C.cid AND
	((F.origin_city = 'Seattle WA' AND F.dest_city = 'New York NY') OR
	(F.origin_city = 'New York NY' AND F.dest_city = 'Seattle WA'))
GROUP BY C.cid, C.name;