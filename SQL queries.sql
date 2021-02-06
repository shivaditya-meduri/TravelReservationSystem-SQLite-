SELECT AVG(fb.price) meanPrice
FROM Flight_booking fb JOIN flight_airline fa JOIN Airline a
        ON (fb.flight_number = fa.flight_number AND fa.airline_id = a.airline_id)
WHERE a.airline_name = "Air France"
GROUP BY a.airline_id;

SELECT COUNT(customer_id) as nbCustomer, country
FROM Customer
GROUP BY country;

SELECT airport_name
FROM Airport
WHERE city = "Paris" AND country = "France";

SELECT city, country
FROM Airport
WHERE airport_id IN
	(SELECT airport_id
	FROM Airport
	GROUP BY city, country
	HAVING count(airport_id) =
		(
		SELECT count(airport_id) as nbAirports
		FROM Airport
		GROUP BY city, country
		ORDER BY nbAirports DESC
		LIMIT 1
		)
	);

SELECT airline_name
FROM Airline
WHERE airline_id IN
	(
	SELECT fa.airline_id
	FROM flight_airline fa JOIN Flight_Schedule fs JOIN Aircraft ac
		ON fa.flight_number = fs.flight_number AND
       fs.aircraft_iata = ac.aircraft_iata
	WHERE ac.aircraft_name = "Airbus A300"
	);

SELECT DISTINCT c.customer_id, c.first_name, c.family_name
FROM Airport a JOIN Flight f ON a.airport_id = f.airport_dst
	JOIN Flight_Schedule fs ON f.flight_id = fs.flight_id
	JOIN Flight_booking fb ON (fs.flight_number = fb.flight_number AND
		fs.departure_date = fb.departure_date)
	JOIN Trip t ON fb.trip_id = t.trip_id
	JOIN Customer c ON t.customer_id = c.customer_id
WHERE a.city = "Sydney" AND a.country = "Australia";

SELECT airport_id, airport_name, city, country
FROM Airport
WHERE airport_id IN
	(
	SELECT dst.airport_dst
	FROM (
				(
				SELECT f.airport_dst, count(*) as num_inbound
				FROM Flight f JOIN Flight_Schedule fs
					ON (f.flight_id = fs.flight_id)
				GROUP BY f.airport_dst
				)  dst JOIN
				(
				SELECT f.airport_src, count(*) as num_outbound
					FROM Flight f JOIN Flight_Schedule fs
						ON (f.flight_id = fs.flight_id)
					GROUP BY f.airport_src
				) src ON dst.airport_dst = src.airport_src
			)
	ORDER BY dst.num_inbound + src.num_outbound DESC
	LIMIT 1
	);

SELECT AVG(price) as meanPrice
FROM Flight_booking
WHERE travel_class = "economy"
GROUP BY travel_class;

SELECT AVG(price) as meanPrice
FROM Flight_booking
WHERE travel_class = "business"
GROUP BY travel_class;

SELECT DISTINCT a.airport_name,  a.city, a.country
FROM Airport a JOIN Flight f ON a.airport_id = f.airport_dst
	JOIN Flight_Schedule fs ON f.flight_id = fs.flight_id
	JOIN Flight_booking fb ON (fs.flight_number = fb.flight_number AND
		fs.departure_date = fb.departure_date)
	JOIN Trip t ON fb.trip_id = t.trip_id
	JOIN Customer c ON t.customer_id = c.customer_id
WHERE c.country = "France";

SELECT DISTINCT a.city, a.country
FROM Airport a JOIN Flight f ON a.airport_id = f.airport_dst
	JOIN Flight_Schedule fs ON f.flight_id = fs.flight_id
	JOIN Flight_booking fb ON (fs.flight_number = fb.flight_number AND
		fs.departure_date = fb.departure_date)
	JOIN Trip t ON fb.trip_id = t.trip_id
	JOIN Customer c ON t.customer_id = c.customer_id
WHERE c.gender = "F";

SELECT DISTINCT a.city, a.country
FROM Airport a JOIN Flight f ON a.airport_id = f.airport_dst
	JOIN Flight_Schedule fs ON f.flight_id = fs.flight_id
	JOIN Flight_booking fb ON (fs.flight_number = fb.flight_number AND
		fs.departure_date = fb.departure_date)
	JOIN Trip t ON fb.trip_id = t.trip_id
	JOIN Customer c ON t.customer_id = c.customer_id
WHERE c.gender = "M";

SELECT country, COUNT(customer_id) as customer_by_country
FROM Customer
WHERE customer_id IN (
	SELECT t.customer_id
	FROM Airport a JOIN Flight f ON a.airport_id = f.airport_dst
		JOIN Flight_Schedule fs ON f.flight_id = fs.flight_id
		JOIN Flight_booking fb ON (fs.flight_number = fb.flight_number AND
			fs.departure_date = fb.departure_date)
		JOIN Trip t ON fb.trip_id = t.trip_id
	WHERE a.city = "Paris" AND a.country = "France"
	)
GROUP BY country;

SELECT city, COUNT(hotel_id) as numHotels
FROM Hotel
GROUP BY city, country;

SELECT SUM(fb.price) amountSpent
FROM Flight_booking fb
	JOIN Trip t ON fb.trip_id = t.trip_id
	JOIN Customer c ON t.customer_id = c.customer_id
WHERE c.first_name = "Tatiana" AND c.family_name = "REZE";

CREATE INDEX my_index ON Customer(family_name);

SELECT *
FROM Customer
Where family_name = 'BELLARD';
