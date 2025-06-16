SELECT MIN(first_contact_date), MAX(first_contact_date)
FROM mql_cp


-- MQL volume
-- by time
SELECT YEAR(first_contact_date) as cyear, MONTH(first_contact_date) as cmonth, COUNT(*) as number_of_mql
FROM mql_cp
GROUP BY YEAR(first_contact_date), MONTH(first_contact_date)
ORDER BY YEAR(first_contact_date), MONTH(first_contact_date)

SELECT * 
FROM mql_cp
WHERE YEAR(first_contact_date) = 2017 AND MONTH(first_contact_date) = 6

SELECT * 
FROM mql_cp
WHERE YEAR(first_contact_date) = 2018 AND MONTH(first_contact_date) = 4


SELECT landing_page_id, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM mql_cp
GROUP BY landing_page_id
ORDER BY 2 DESC

SELECT origin, landing_page_id, COUNT(*)
FROM mql_cp
GROUP BY origin, landing_page_id
ORDER BY 3 DESC

GO

CREATE VIEW customers AS
(SELECT cd.mql_id, first_contact_date, origin, won_date, lead_type, business_segment, business_type
FROM closed_deals_cp cd
JOIN mql_cp
ON cd.mql_id = mql_cp.mql_id)

GO 

-- by orgigin
SELECT origin, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM customers
GROUP BY origin
ORDER BY 2 DESC

-- by business segment
SELECT business_segment, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM customers
GROUP BY business_segment
ORDER BY 2 DESC

-- by lead type
SELECT lead_type, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM customers
GROUP BY lead_type
ORDER BY 2 DESC

-- by business type
SELECT business_type, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM customers
GROUP BY business_type
ORDER BY 2 DESC

GO

-- lead-to-close rate
CREATE VIEW mcd AS
(SELECT mql_cp.mql_id, first_contact_date, origin, won_date, lead_type, business_segment, business_type, 
DATEDIFF(day, first_contact_date, won_date) as conversion_time,
	CASE 
		WHEN won_date IS NULL THEN 0
		ELSE 1
	END AS closed
FROM closed_deals_cp cd
RIGHT JOIN mql_cp
ON cd.mql_id = mql_cp.mql_id)

GO

SELECT YEAR(first_contact_date) as cyear, MONTH(first_contact_date) as cmonth, 
	COUNT(*) AS leads,
	SUM(closed) AS closed_deals,
	SUM(closed) * 100.0 / COUNT(*)AS lead_to_close
FROM mcd
GROUP BY YEAR(first_contact_date), MONTH(first_contact_date)
ORDER BY YEAR(first_contact_date), MONTH(first_contact_date)

-- time to convert 
SELECT MAX(conversion_time), MIN(conversion_time), AVG(conversion_time)
FROM mcd
WHERE 
closed = 1 AND conversion_time > -1

SELECT time_range, COUNT(*) as closed_deals_count, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM
(
SELECT 
	CASE
	WHEN conversion_time > 365 THEN '> 365 days'
	WHEN conversion_time > 180 THEN '180-365 days'
	WHEN conversion_time > 90 THEN '90-180 days'
	WHEN conversion_time > 30 THEN '30-90 days'
	ELSE '< 30 days'
	END as time_range
FROM mcd
WHERE closed = 1 ) time_group
GROUP BY time_range
ORDER BY 2 DESC


-- time to convert by origin
SELECT origin, AVG(DATEDIFF(day, first_contact_date, won_date))  
FROM mcd
WHERE closed = 1
GROUP BY origin
ORDER BY 2 DESC
