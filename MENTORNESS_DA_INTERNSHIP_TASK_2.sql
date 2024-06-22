/*Q1*/ SELECT * FROM internshiptask.corona WHERE Province IS NOT NULL OR Latitude IS NOT NULL 
OR Longitude IS NOT NULL OR Date IS NOT NULL OR Confirmed IS NOT NULL OR Deaths IS NOT NULL
OR Recovered IS NOT NULL;

/* Q2 asks to replace any existing null values with 0 */
/* Q2 */ SELECT *, IFNULL(Confirmed,0) AS Confirmed, IFNULL(Recovered,0), IFNULL(Deaths,0) FROM internshiptask.corona;

/* Q3 check total number of rows */
SELECT COUNT(*) AS Total_Count FROM internshiptask.corona;

/* Q4 Check Start and end date */
SELECT MIN(Date) AS Start_Date, MAX(Date) AS End_Date FROM internshiptask.corona;

/* Q5 Number of Months in the dataset */
SELECT COUNT(DISTINCT MONTH(Date)) AS No_Of_Months FROM internshiptask.corona;

/* Q6 Find monthly average for Confirmed, Recovered, Deaths */
SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, AVG(Recovered) AS AVG_RECOVERED, AVG(Deaths) AS AVG_DEATHS, 
AVG(Confirmed) AS AVG_CONFIRMED FROM internshiptask.corona GROUP BY YEAR(Date), MONTH(Date) ORDER BY Year, Month;

/* Q7 Find the Most Frequent value for Confirmed, Deaths, and Recovered for every month */
WITH monthly_data AS (
  SELECT
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    Confirmed,
    Deaths,
    Recovered,
    COUNT(*) AS count
  FROM internshiptask.corona
  GROUP BY YEAR(Date), MONTH(Date), Confirmed, Deaths, Recovered
)
SELECT
  md.year,
  md.month,
  md.Confirmed,
  md.Deaths,
  md.Recovered,
  md.count
FROM monthly_data AS md
INNER JOIN (
  SELECT year, month, MAX(count) AS max_count
  FROM monthly_data
  GROUP BY year, month ORDER BY year, month
) AS max_counts
ON md.year = max_counts.year
AND md.month = max_counts.month
AND md.count = max_counts.max_count;

/* Q8 Find Minumum values for Confirmed, Deaths, Recovered per year */

SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, MIN(Confirmed), MIN(Deaths), MIN(Recovered) FROM internshiptask.corona GROUP BY Year, Month;

/* Q9 Find Maximum values for Confirmed, Deaths, Recovered per year */

SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, MAX(Confirmed), MAX(Deaths), MAX(Recovered) FROM internshiptask.corona GROUP BY YEAR, Month;

/* Q10 Find the total number of Confirmed, Deaths, Recovered per month */

SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, COUNT(Confirmed), COUNT(Deaths), COUNT(Recovered) 
FROM internshiptask.corona GROUP BY Year, Month;

/* Q11 Check the spread of COVID with respect to confirm cases (total, average, variance, standard deviation) */

SELECT YEAR(Date) AS Year, MONTH(DATE) AS Month, COUNT(Confirmed) AS Total, AVG(Confirmed) as Average, 
STDDEV(Confirmed) as Standard_Deviation, VARIANCE(Confirmed) as VARIANCE FROM internshiptask.corona GROUP BY YEAR, MONTH;

/* Q12 Check the spread of COVID with respect to death cases (total, average, variance, standard deviation) */

SELECT YEAR(Date) AS Year, MONTH(DATE) AS Month, COUNT(Deaths) AS Total_Deaths, AVG(Deaths) as Average_Deaths, 
STDDEV(Deaths) as Standard_Deviation_of_Deaths, VARIANCE(Deaths) as VARIANCE_Of_Deaths FROM internshiptask.corona GROUP BY YEAR, MONTH;

/* Q13 Check the spread of COVID with respect to recovered cases (total, average, variance, standard deviation) */

SELECT YEAR(Date) AS Year, MONTH(DATE) AS Month, COUNT(Recovered) AS Total_Recovered, AVG(Recovered) as Average_Recovered, 
STDDEV(Recovered) as Standard_Deviation_of_recovered, VARIANCE(Recovered) as VARIANCE_of_recovered 
FROM internshiptask.corona GROUP BY YEAR, MONTH;

/* Q14 Find the country with the highest number of Confirmed Cases */

SELECT Province, SUM(Confirmed) as Confirmed_Cases FROM internshiptask.corona GROUP BY Province Order By Confirmed_Cases DESC LIMIT 1;

/* Q15 Find the country having lowest death cases */

SELECT Province, SUM(Deaths) AS Death_Cases FROM internshiptask.corona GROUP BY Province ORDER BY Death_Cases LIMIT 1;

/* Q16 Find Top 5 Countries having highest recovered cases */

SELECT Province, SUM(Recovered) FROM internshiptask.corona GROUP BY Province ORDER BY SUM(Recovered) DESC LIMIT 5;