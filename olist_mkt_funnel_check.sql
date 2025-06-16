-- create a copy of the raw data
SELECT *
INTO mql_cp
FROM mql

ALTER TABLE mql_cp
ADD CONSTRAINT PK_mql_id PRIMARY KEY (mql_id)

SELECT *
INTO closed_deals_cp
FROM closed_deals

ALTER TABLE closed_deals_cp
ADD CONSTRAINT PK_closed_deals_cp PRIMARY KEY (mql_id)

-- inspect marketing qualified lead table
SELECT *
FROM mql_cp
ORDER BY first_contact_date

-- inspect duplicate
SELECT mql_id, landing_page_id, origin, first_contact_date, COUNT(*)
FROM mql_cp
GROUP BY mql_id, landing_page_id, origin, first_contact_date
HAVING COUNT(*) > 1

-- inspect landing page
SELECT DISTINCT(landing_page_id)
FROM mql_cp

-- inspect lead sources
SELECT origin, COUNT(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM mql_cp
GROUP BY origin
ORDER BY 2 DESC

-- recategorized null value in origin to 'unknown'
UPDATE mql_cp
SET origin = 'unknown'
WHERE origin IS NULL

-- recategorized other_publicites to other
UPDATE mql_cp
SET origin = 'other'
WHERE origin = 'other_publicities'

-- contact date
SELECT YEAR(first_contact_date) as cyear, MONTH(first_contact_date) as cmonth, COUNT(*) as number_of_mql
FROM mql_cp
GROUP BY YEAR(first_contact_date), MONTH(first_contact_date)
ORDER BY YEAR(first_contact_date), MONTH(first_contact_date)

-- inspect closed deals table
SELECT *
FROM closed_deals_cp

-- checking for duplicates in id
SELECT 
	COUNT(*) as number_of_rows,
	COUNT(DISTINCT(seller_id)) as number_of_sellers, 
	COUNT(mql_id) as number_of_mql
FROM closed_deals_cp

-- checking unique sr, sdr
SELECT 
	COUNT(DISTINCT(sr_id)) as number_of_sr,
	COUNT(DISTINCT(sdr_id)) as number_of_sdr
FROM closed_deals_cp

-- inspect insensible won date
SELECT 
	cd.mql_id,
	first_contact_date,
	won_date
FROM closed_deals_cp cd
JOIN mql_cp
ON cd.mql_id = mql_cp.mql_id
WHERE first_contact_date > won_date

-- inspect business segment
SELECT business_segment, COUNT(*)as number_of_business_segments, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM closed_deals_cp
GROUP BY business_segment
ORDER BY 2 DESC

-- inspect lead type
SELECT lead_type, COUNT(*) as number_of_lead_types, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM closed_deals_cp
GROUP BY lead_type
ORDER BY 2 DESC

SELECT *
FROM closed_deals_cp
WHERE lead_type IS NULL or business_segment IS NULL or business_type IS NULL

-- recategorized lead type
UPDATE closed_deals_cp
SET lead_type = 'online'
WHERE lead_type LIKE 'online%'

-- inspect lead behavior profile
SELECT lead_behaviour_profile, COUNT(*) as number_of_lead_profiles, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM closed_deals_cp
GROUP BY lead_behaviour_profile
ORDER BY 2 DESC

-- remove lead behavior profile
ALTER TABLE closed_deals_cp
DROP COLUMN lead_behaviour_profile

-- inspect has company
SELECT has_company, COUNT(*) as number_of_companies, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM closed_deals_cp
GROUP BY has_company
ORDER BY 2 DESC

-- remove has company
ALTER TABLE closed_deals_cp
DROP COLUMN has_company

-- inspect business type
SELECT business_type, COUNT(*) as number_of_business_types, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM closed_deals_cp
GROUP BY business_type
ORDER BY 2 DESC

-- inspect declared monthly revenue
SELECT invalid_revenue, COUNT(*) as number_of_business_types, (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage
FROM
(SELECT 
	CASE
		WHEN declared_monthly_revenue = 0 OR declared_monthly_revenue IS NULL THEN 1
		ELSE 0
		END as invalid_revenue
FROM closed_deals_cp) tab
GROUP BY invalid_revenue

-- remove declared monthly revenue
ALTER TABLE closed_deals_cp
DROP COLUMN declared_monthly_revenue
