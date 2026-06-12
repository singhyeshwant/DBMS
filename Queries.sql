-- Task D.1 --
WITH vaccination_counts AS (
SELECT
v.all_iso_code,
v.vaccination_date,
v.people_vaccinated,
ROW_NUMBER() OVER (PARTITION BY v.all_iso_code ORDER BY v.vaccination_date) - 1 AS DN
FROM
vaccinations v
INNER JOIN
locations_info li ON v.all_iso_code = li.iso_code
)
SELECT
li.location AS "Country Name (CN)",
vc.DN AS "Administered Vaccine on Day Number (DN)", SUM(vc.people_vaccinated) OVER (PARTITION BY vc.all_iso_code ORDER BY vc.vaccination_date) AS "Total Injected People"
FROM
vaccination_counts vc
INNER JOIN
locations_info li ON vc.all_iso_code = li.iso_code
ORDER BY
li.location, vc.DN;

-- Task D.2 --
SELECT
locations_info.location AS Country,
SUM(vaccinations.people_vaccinated + vaccinations.people_fully_vaccinated) AS "Cumulative Doses"
FROM
locations_info
JOIN
vaccinations ON locations_info.iso_code = vaccinations.all_iso_code
GROUP BY
locations_info.iso_code
ORDER BY
"Cumulative Doses" DESC;

-- Task D.3 --
SELECT
vaccine_type.vaccines AS "Vaccine Type",
locations_info.location AS Country
FROM
vaccine_type
JOIN
locations_info ON vaccine_type.vac_iso_code = locations_info.iso_code ORDER BY
"Vaccine Type", Country;

-- Task D.4 --
SELECT
locations.source_website AS "Source Name (URL)", MAX(vaccinations.total_vaccinations) AS "Largest Total Administered Vaccines" FROM
vaccinations
JOIN
locations_info ON vaccinations.all_iso_code = locations_info.iso_code
JOIN
locations ON locations_info.iso_code = locations.iso_code
GROUP BY
locations.source_website
ORDER BY
"Source Name (URL)";
;

-- Task D.5 --
SELECT
    strftime('%Y-%m', vaccinations.vaccination_date) AS Date,
    SUM(CASE WHEN locations_info.location = 'Australia' THEN vaccinations.people_fully_vaccinated ELSE 0 END) AS Australia,
    SUM(CASE WHEN locations_info.location = 'United States' THEN vaccinations.people_fully_vaccinated ELSE 0 END) AS "United States",
    SUM(CASE WHEN locations_info.location = 'England' THEN vaccinations.people_fully_vaccinated ELSE 0 END) AS England,
    SUM(CASE WHEN locations_info.location = 'New Zealand' THEN vaccinations.people_fully_vaccinated ELSE 0 END) AS "New Zealand"
FROM
    vaccinations
JOIN
    locations_info ON vaccinations.all_iso_code = locations_info.iso_code
WHERE
    vaccinations.vaccination_date >= '2022-01-01' AND vaccinations.vaccination_date <= '2022-12-31'
GROUP BY
    Date;

-- END --