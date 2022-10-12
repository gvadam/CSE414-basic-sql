-- Question 2

-- Return all itineraries from Boston to Seattle on July 4th
-- that only has one stop, with a total flight time under 8 hours
-- return 1194 rows in output
SELECT C.name AS name, F1.flight_num AS f1_flight_num,
	F1.origin_city AS f1_origin_city, F1.dest_city AS f1_dest_city,
	F1.actual_time AS f1_actual_time, F2.flight_num AS f2_flight_num,
	F2.origin_city AS f2_origin_city, F2.dest_city AS f2_dest_city,
	F2.actual_time AS f2_actual_time,
	(F1.actual_time + F2.actual_time) AS actual_time
FROM FLIGHTS AS F1, FLIGHTS AS F2, CARRIERS AS C, MONTHS AS M
WHERE F1.carrier_id = C.cid AND F2.carrier_id = C.cid
	AND F1.month_id = M.mid AND F2.month_id = M.mid
	AND F1.origin_city = 'Boston MA' AND F2.dest_city = 'Seattle WA'
	AND F1.dest_city = F2.origin_city
	AND M.month = 'July'
	AND F1.day_of_month = 4 AND F2.day_of_month = 4
	AND (F1.actual_time + F2.actual_time) < 480;