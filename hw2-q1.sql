-- Question 1

-- Return the distinct flight numbers from seattle to 
-- Boise by "Alaska Airlines Inc." on fridays.
-- returns three rows in ouput
SELECT DISTINCT F.flight_num AS flight_num
FROM FLIGHTS AS F, CARRIERS AS C, WEEKDAYS AS W
WHERE F.carrier_id = C.cid AND F.day_of_week_id = W.did
	AND F.origin_city = 'Seattle WA'
	AND F.dest_city = 'Boise ID'
	AND C.name = 'Alaska Airlines Inc.'
	AND W.day_of_week = 'Friday';
