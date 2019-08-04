#####Basic SQL 1#####

SELECT year, month, west
FROM tutorial.us_housing_units
  
SELECT *
FROM tutorial.us_housing_units

SELECT west AS "West Region"
  FROM tutorial.us_housing_units

## lower case of west_region without quotation
SELECT west AS West_Region, 
       south AS South_Region
  FROM tutorial.us_housing_units
  
SELECT *
  FROM tutorial.us_housing_units
 LIMIT 15
 
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month = 1
 
 ## Did the West Region ever produce more than 50,000 housing units in one month?
 SELECT *
  FROM tutorial.us_housing_units
 WHERE west > 50
 
 ## Did the South Region ever produce 20,000 or fewer housing units in one month?
 SELECT *
  FROM tutorial.us_housing_units
 WHERE south <= 20
 

## Equal to	=
##Not equal to	<> or !=
##Greater than	>
##Less than	<
##Greater than or equal to	>=
##Less than or equal to	<=


 ## SQL considers ‘Ja’ to be greater than ‘J’ because it has an extra letter.
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name > 'January'
 
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name > 'J'
 
 ## Write a query that only shows rows for which the month name is February.
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name = "February"
 
 ## Write a query that only shows rows for which the month_name starts with the letter "N" or an earlier letter in the alphabet.
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name < 'o'
 
 SELECT year,
       month,
       west,
       south,
       west + south - 4 * year AS nonsense_column
  FROM tutorial.us_housing_units
 
 ## Write a query that calculates the sum of all four regions in a separate column.
 SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest +northeast AS usa_total
  FROM tutorial.us_housing_units
  
## Write a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined.
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast
FROM tutorial.us_housing_units
WHERE west > (midwest + northeast)

## Write a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later. 
SELECT year, month,
      west/(west + south + midwest + northeast) AS west_per,
      south/(west + south + midwest +northeast)AS south_per,
      midwest/(west + south + midwest +northeast) AS midwest_per,
      northeast/(west + south + midwest +northeast) AS ne_per
FROM tutorial.us_housing_units
WHERE year >= 2000









#####Basic SQL 2#####

##LIKE allows you to match similar values, instead of exact values.
##IN allows you to specify a list of values you’d like to include.
##BETWEEN allows you to select only rows within a certain range.
##IS NULL allows you to select rows that contain no data in a given column.
##AND allows you to select only rows that satisfy two conditions.
##OR allows you to select rows that satisfy either of two conditions.
##NOT allows you to select rows that do not match a certain condition.

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'Snoop%'
 
##ignore case-sensitive using ILIKE
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE 'snoop%'
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
WHERE artist ILIKE 'dr_ke'

##Write a query that returns all rows for which Ludacris was a member of the group.
SELECT * 
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE '%Ludacris%'

##Write a query that returns all rows for which the first artist listed in the group has a name that begins with "DJ".
SELECT * 
FROM tutorial.billboard_top_100_year_end
WHERE "group" ILIKE 'DJ%'

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank IN (1, 2, 3)
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE artist IN ('Taylor Swift', 'Usher', 'Ludacris')
 
## Write a query that shows all of the entries for Elvis and M.C. Hammer. 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" IN ('M.C. Hammer', 'Hammer', 'Elvis Presley')
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank BETWEEN 5 AND 10
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank >= 5 AND year_rank <= 10

## Write a query that shows all top 100 songs from January 1, 1985 through December 31, 1990.
SELECT * 
  FROM tutorial.billboard_top_100_year_end
  WHERE year BETWEEN 1985 AND 1990

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE artist IS NULL

## Write a query that shows all of the rows for which song_name is null.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name IS NULL
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2012
   AND year_rank <= 10
   AND "group" ILIKE '%feat%'

##Write a query that surfaces all rows for top-10 hits for which Ludacris is part of the Group.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank <= 10
   AND "group" ILIKE '%Ludacris%'

##Write a query that surfaces the top-ranked records in 1990, 2000, and 2010
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank = 1
   AND year IN (1990,2000,2010)

## Write a query that lists all songs from the 1960s with "love" in the title.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year BETWEEN 1960 AND 1969
   AND song_name ILIKE '%love%'
   
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank = 5 OR artist = 'Gotye'
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND ("group" ILIKE '%macklemore%' OR "group" ILIKE '%timberlake%')
   
##Write a query that returns all rows for top-10 songs that featured either Katy Perry or Bon Jovi.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank <= 10 AND ("group" ILIKE '%Katy Perry%' OR "group" ILIKE '%Bon Jovi%')
 
##Write a query that returns all songs with titles that contain the word "California" in either the 1970s or 1990s.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name ILIKE '%california%' AND ((year BETWEEN 1960 AND 1969) OR (year BETWEEN 1990 AND 1999) )
 
##Write a query that lists all top-100 recordings that feature Dr. Dre before 2001 or after 2009.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE (year <= 2000 OR year >= 2010) AND "group" ILIKE '%dr. dre%'
 
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND "group" NOT ILIKE '%macklemore%'
   
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND artist IS NOT NULL

--Write a query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND song_name NOT ILIKE '%a%'
   
SELECT *
  FROM tutorial.billboard_top_100_year_end
 ORDER BY artist

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
 ORDER BY year_rank DESC
 
--Write a query that returns all rows from 2010 ordered by rank, with artists ordered alphabetically for each song.
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2010
 ORDER BY year_rank, artist

--Write a query that shows all rows for which T-Pain was a group member, ordered by rank on the charts, from lowest to highest rank (from 100 to 1).
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%t-pain%'
 ORDER BY year_rank DESC
 
--Write a query that returns songs that ranked between 10 and 20 (inclusive) in 1993, 2003, or 2013. Order the results by year and rank, and leave a comment on each line of the WHERE clause to indicate what that line does
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE (year_rank BETWEEN 10 AND 20) AND year IN (1993,2003, 2013)
 ORDER BY year, year_rank
















#####Intermediate SQL 1#####

--COUNT counts how many rows are in a particular column.
--SUM adds together all the values in a particular column.
--MIN and MAX return the lowest and highest values in a particular column, respectively.
--AVG calculates the average of a group of selected values.

SELECT COUNT(*)
  FROM tutorial.aapl_historical_stock_price
  
SELECT COUNT(high)
  FROM tutorial.aapl_historical_stock_price
  
SELECT COUNT(date) AS count_of_date
  FROM tutorial.aapl_historical_stock_price
  
SELECT COUNT(date) AS "Count Of Date"
  FROM tutorial.aapl_historical_stock_price
  
--Write a query that determines counts of every single column. Which column has the most null values?
SELECT COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT(open) AS open,
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT(close) AS close,
       COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price --high has the most null-values

SELECT SUM(volume)
  FROM tutorial.aapl_historical_stock_price
  
--Write a query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).
SELECT SUM(open)/COUNT(open)
  FROM tutorial.aapl_historical_stock_price
  
SELECT MIN(volume) AS min_volume,
       MAX(volume) AS max_volume
  FROM tutorial.aapl_historical_stock_price

--What was Apple's lowest stock price (at the time of this data collection)?
SELECT MIN(low)
  FROM tutorial.aapl_historical_stock_price
  
--What was the highest single-day increase in Apple's share value?
SELECT MAX(close - open)
  FROM tutorial.aapl_historical_stock_price
  
SELECT AVG(high)
  FROM tutorial.aapl_historical_stock_price
 WHERE high IS NOT NULL -- avg ignores null completely
 
--Write a query that calculates the average daily trade volume for Apple stock.
SELECT AVG(volume) AS avg_volume
  FROM tutorial.aapl_historical_stock_price
  
SELECT year,
       month,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month

--Calculate the total number of shares traded each month. Order your results chronologically.
SELECT year,
       month,
       SUM(volume)
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year, month
 
SELECT year,
       month,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY month, year
 
--Write a query to calculate the average daily price change in Apple stock, grouped by year.
SELECT AVG(close-open)
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY year
 
--Write a query that calculates the lowest and highest prices that Apple stock achieved each month.
SELECT MIN(low), MAX(high)
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year, month
 
SELECT year,
       month,
       MAX(high) AS month_high
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
HAVING MAX(high) > 400
 ORDER BY year, month
 
SELECT DISTINCT year, month
  FROM tutorial.aapl_historical_stock_price
  
--Write a query that returns the unique values in the year column, in chronological order.
SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
  ORDER BY year
  
SELECT COUNT(DISTINCT month) AS unique_months
  FROM tutorial.aapl_historical_stock_price

SELECT month,
       AVG(volume) AS avg_trade_volume
  FROM tutorial.aapl_historical_stock_price
 GROUP BY month
 ORDER BY month DESC
 
--Write a query that counts the number of unique values in the month column for each year.
SELECT year, COUNT(DISTINCT month)
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY year
--Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.
SELECT COUNT(DISTINCT year) AS years_count,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price

SELECT player_name,
       year,
       CASE WHEN year = 'SR' THEN 'yes'
            ELSE NULL END AS is_a_senior
  FROM benn.college_football_players
  
--Write a query that includes a column that is flagged "yes" when a player is from California, and sort the results with those players first.
SELECT player_name,
       year,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE 'NO' END AS is_ca
  FROM benn.college_football_players
  ORDER BY is_ca
  
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 AND weight <= 250 THEN '201-250'
            WHEN weight > 175 AND weight <= 200 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players

--Write a query that includes players' names and a column that classifies them into four categories based on height. Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights in many ways.
SELECT player_name,
       height,
       CASE WHEN height > 74 THEN 'over 74'
            WHEN height > 72 AND height <= 74 THEN '73-74'
            WHEN height > 70 AND height <= 72 THEN '71-72'
            ELSE 'under 70' END AS height_group
  FROM benn.college_football_players

--The CASE statement always goes in the SELECT clause
--CASE must include the following components: WHEN, THEN, and END. ELSE is an optional component.
--You can make any conditional statement using any conditional operator (like WHERE) between WHEN and THEN. This includes stringing together multiple conditional statements using AND and OR.
--You can include multiple WHEN statements, as well as an ELSE statement to deal with any unaddressed conditions.

SELECT player_name,
       CASE WHEN year = 'FR' AND position = 'WR' THEN 'frosh_wr'
            ELSE NULL END AS sample_case_statement
  FROM benn.college_football_players
  
--Write a query that selects all columns from benn.college_football_players and adds an additional column that displays the player's name if that player is a junior or senior.
SELECT *,
       CASE WHEN year = 'FR' OR year = 'SO' THEN 'YES'
            ELSE 'NO' END AS is_junior_or_senior
FROM benn.college_football_players

SELECT CASE WHEN year = 'FR' THEN 'FR'
            ELSE 'Not FR' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY CASE WHEN year = 'FR' THEN 'FR'
               ELSE 'Not FR' END
               
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY year_group
 
--Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (Everywhere else).
SELECT CASE WHEN state IN ('CA','OR','WA') THEN 'West_Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'ELSE' END AS state_group,
            COUNT(1) AS count
  FROM benn.college_football_players
  WHERE weight >= 300
 GROUP BY state_group
 
--Write a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California.
SELECT CASE WHEN year IN ('FR','SO') THEN 'underclass'
            WHEN year IN ('JR','SR') THEN 'upperclass'
            END AS class_group,
            COUNT(1) AS count, 
            SUM(weight)
  FROM benn.college_football_players
  WHERE state = 'CA'
 GROUP BY class_group

-- vertically 
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY 1
-- horizontally
SELECT COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count
  FROM benn.college_football_players
  
--Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.
SELECT state, 
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(player_name) AS total_players
  FROM benn.college_football_players
 GROUP BY state
 
--Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
SELECT CASE WHEN school_name < 'n'  THEN 'A-M' 
            WHEN school_name >= 'n'  THEN 'N-Z' 
            ELSE NULL END as school_name_group, 
            COUNT(CASE WHEN school_name < 'n'  THEN 'A-M' 
            WHEN school_name >= 'n'  THEN 'N-Z' 
            ELSE NULL END) as count
  FROM benn.college_football_players
  GROUP BY school_name_group









#####Intermediate SQL 2#####
SELECT teams.conference AS conference,
       AVG(players.weight) AS average_weight
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams -- inner join: join / inner join
    ON teams.school_name = players.school_name
 GROUP BY teams.conference
 ORDER BY AVG(players.weight) DESC

--Write a query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
SELECT *
  FROM benn.college_football_players
SELECT *
  FROM benn.college_football_teams
SELECT players.player_name, players.school_name,teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams -- inner join: join / inner join
    ON teams.school_name = players.school_name
  WHERE teams.division = 'FBS (Division I-A Teams)'
  
SELECT companies.permalink AS companies_permalink,
       companies.name AS companies_name,
       acquisitions.company_permalink AS acquisitions_permalink,
       acquisitions.acquired_at AS acquired_date
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

--Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table
SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
   LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

-- Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.
SELECT COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS unique_acquisitions
  FROM tutorial.crunchbase_companies companies
   LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
  WHERE companies.state_code IS NOT NULL
  GROUP BY companies.state_code 
  ORDER BY unique_acquisitions DESC

--If you move the same filter to the WHERE clause, you will notice that the filter happens after the tables are joined. The result is that the 1000memories row is joined onto the original table, but then it is filtered out entirely (in both tables) in the WHERE clause before displaying results.
SELECT companies.permalink AS companies_permalink,
       companies.name AS companies_name,
       acquisitions.company_permalink AS acquisitions_permalink,
       acquisitions.acquired_at AS acquired_date
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
 WHERE acquisitions.company_permalink != '/company/1000memories'
    OR acquisitions.company_permalink IS NULL
 ORDER BY 1
 
--Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York
SELECT companies.name AS companies_name,
       companies.status AS company_status,
       COUNT(DISTINCT investments.investor_name) AS unique_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
      WHERE companies.state_code = 'NY'
      GROUP BY companies_name, company_status
ORDER BY unique_investors DESC

--Write a query that lists investors based on the number of companies in which they are invested. Include a row for companies with no investor, and order from most companies to least.
SELECT investments.investor_name AS investors,
       COUNT(DISTINCT companies.name) AS unique_companies,
       CASE WHEN COUNT(DISTINCT companies.name) = 0 THEN 'YES' ELSE 'NO' END AS zero_company  
  FROM tutorial.crunchbase_companies companies
  RIGHT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
  GROUP BY investments.investor_name
  ORDER BY unique_companies DESC -- wrong withn 4min
  
SELECT CASE WHEN investments.investor_name IS NULL THEN 'No Investors'
            ELSE investments.investor_name END AS investor,
       COUNT(DISTINCT companies.permalink) AS companies_invested_in
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1
 ORDER BY 2 DESC

SELECT COUNT(CASE WHEN companies.permalink IS NOT NULL AND acquisitions.company_permalink IS NULL
                  THEN companies.permalink ELSE NULL END) AS companies_only,
       COUNT(CASE WHEN companies.permalink IS NOT NULL AND acquisitions.company_permalink IS NOT NULL
                  THEN companies.permalink ELSE NULL END) AS both_tables,
       COUNT(CASE WHEN companies.permalink IS NULL AND acquisitions.company_permalink IS NOT NULL
                  THEN acquisitions.company_permalink ELSE NULL END) AS acquisitions_only
  FROM tutorial.crunchbase_companies companies
  FULL JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
    
--Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. Count up the number of rows that are matched/unmatched as in the example above.
SELECT COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NULL
                  THEN companies.permalink ELSE NULL END) AS companies_only,
       COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NOT NULL
                  THEN companies.permalink ELSE NULL END) AS both_tables,
       COUNT(CASE WHEN companies.permalink IS NULL AND investments.company_permalink IS NOT NULL
                  THEN investments.company_permalink ELSE NULL END) AS investments_only
  FROM tutorial.crunchbase_companies companies
  FULL JOIN tutorial.crunchbase_investments_part1 investments
  ON companies.permalink = investments.company_permalink

--Both tables must have the same number of columns
--The columns must have the same data types in the same order as the first table
SELECT *
  FROM tutorial.crunchbase_investments_part1
 UNION ALL
 SELECT *
   FROM tutorial.crunchbase_investments_part2
   
--Write a query that appends the two crunchbase_investments datasets above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M" (both not case-sensitive). Only include the company_permalink, company_name, and investor_name columns.
SELECT company_permalink, company_name, investor_name
  FROM tutorial.crunchbase_investments_part1
  WHERE company_name ILIKE 't%'
 UNION ALL
 SELECT company_permalink, company_name, investor_name
   FROM tutorial.crunchbase_investments_part2
   WHERE company_name ILIKE 'm%'
   
--Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, the second shows company status, and the third is a count of the number of investors. 
SELECT 'investments_part1' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

 UNION ALL
 
 SELECT 'investments_part2' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

SELECT companies.permalink,
       companies.name,
       companies.status,
       COUNT(investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
   AND investments.funded_year > companies.founded_year + 5
 GROUP BY 1,2, 3
 
SELECT companies.permalink,
       companies.name,
       companies.status,
       COUNT(investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
   AND investments.funded_year > companies.founded_year + 5
 GROUP BY 1,2, 3
--It’s important to note that this produces a different result than the following query because it only joins rows that fit the investments.funded_year > companies.founded_year + 5 condition rather than joining all rows and then filtering:
SELECT companies.permalink,
       companies.name,
       companies.status,
       COUNT(investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 WHERE investments.funded_year > companies.founded_year + 5
 GROUP BY 1,2, 3

-- join based on multiple keys
SELECT companies.permalink,
       companies.name,
       investments.company_name,
       investments.company_permalink
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
   AND companies.name = investments.company_name
   
--Sometimes it can be useful to join a table to itself. Let’s say you wanted to identify companies that received an investment from Great Britain following an investment from Japan.
SELECT DISTINCT japan_investments.company_name,
       japan_investments.company_permalink
  FROM tutorial.crunchbase_investments_part1 japan_investments
  JOIN tutorial.crunchbase_investments_part1 gb_investments
    ON japan_investments.company_name = gb_investments.company_name
   AND gb_investments.investor_country_code = 'GBR'
   AND gb_investments.funded_at > japan_investments.funded_at
 WHERE japan_investments.investor_country_code = 'JPN'
 ORDER BY 1




















#####Advanced SQL 1#####
-- Change column types
CAST(column_name AS integer)
column_name::integer

--Convert the funding_total_usd and founded_at_clean columns in the tutorial.crunchbase_companies_clean_date table to strings (varchar format) using a different formatting function for each one.
SELECT CAST(funding_total_usd AS varchar) AS funding_total_usd_string,
       founded_at_clean::varchar AS founded_at_string
  FROM tutorial.crunchbase_companies_clean_date
  
-- Change Date/Time
SELECT permalink,
       founded_at
  FROM tutorial.crunchbase_companies_clean_date
 ORDER BY 
 
SELECT companies.permalink,
       companies.founded_at_clean,
       companies.founded_at_clean::timestamp +
         INTERVAL '1 week' AS plus_one_week
  FROM tutorial.crunchbase_companies_clean_date companies
 WHERE founded_at_clean IS NOT NULL
 
SELECT companies.permalink,
       companies.founded_at_clean,
       NOW() - companies.founded_at_clean::timestamp AS founded_time_ago
  FROM tutorial.crunchbase_companies_clean_date companies
 WHERE founded_at_clean IS NOT NULL
 
--Write a query that counts the number of companies acquired within 3 years, 5 years, and 10 years of being founded (in 3 separate columns). Include a column for total companies acquired as well. Group by category and limit to only rows with a founding date.
SELECT companies.category_code,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '3 years'
                       THEN 1 ELSE NULL END) AS acquired_3_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '5 years'
                       THEN 1 ELSE NULL END) AS acquired_5_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '10 years'
                       THEN 1 ELSE NULL END) AS acquired_10_yrs,
       COUNT(1) AS total
  FROM tutorial.crunchbase_companies_clean_date companies
  JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions
    ON acquisitions.company_permalink = companies.permalink
 WHERE founded_at_clean IS NOT NULL
 GROUP BY 1
 ORDER BY 5 DESC

SELECT *
  FROM tutorial.sf_crime_incidents_2014_01
LIMIT 10



SELECT incidnt_num,
       date,
       LEFT(date, 10) AS cleaned_date,
       RIGHT(date, LENGTH(date) - 11) AS cleaned_time
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT location,
       TRIM(both '()' FROM location)
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       descript,
       POSITION('A' IN descript) AS a_position
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       descript,
       STRPOS(descript, 'A') AS a_position
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       date,
       SUBSTR(date, 4, 2) AS day
  FROM tutorial.sf_crime_incidents_2014_01
  
--Write a query that separates the `location` field into separate fields for latitude and longitude. You can compare your results against the actual `lat` and `lon` fields in the table.
SELECT location,
       TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) - 1)) AS lattitude,
       TRIM(trailing ')' FROM RIGHT(location, LENGTH(location) - POSITION(',' IN location) ) ) AS longitude
  FROM tutorial.sf_crime_incidents_2014_01

SELECT incidnt_num,
       day_of_week,
       LEFT(date, 10) AS cleaned_date,
       CONCAT(day_of_week, ', ', LEFT(date, 10)) AS day_and_date
  FROM tutorial.sf_crime_incidents_2014_01
  
--Concatenate the lat and lon fields to form a field that is equivalent to the location field. (Note that the answer will have a different decimal precision.)
SELECT location, 
       CONCAT('(',lat,',',lon,')') AS concat_location
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       day_of_week,
       LEFT(date, 10) AS cleaned_date,
       day_of_week || ', ' || LEFT(date, 10) AS day_and_date
  FROM tutorial.sf_crime_incidents_2014_01

-- Create the same concatenated location field, but using the || syntax instead of CONCAT.
SELECT location, 
       '(' || lat || ',' || lon || ')' AS concat_location
  FROM tutorial.sf_crime_incidents_2014_01
  
--Write a query that creates a date column formatted YYYY-MM-DD.
SELECT date, 
       SUBSTR(date, 7,4) || '-' || SUBSTR(date, 1,2) || '-' || SUBSTR(date, 4,2) AS cleaned_date
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       address,
       UPPER(address) AS address_upper,
       LOWER(address) AS address_lower
  FROM tutorial.sf_crime_incidents_2014_01
  
--Write a query that returns the `category` field, but with the first letter capitalized and the rest of the letters in lower-case.
SELECT category, 
       UPPER(LEFT(category,1)) || LOWER(RIGHT(category, LENGTH(category)-1)) AS revised_category
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT incidnt_num,
       date,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2))::date AS cleaned_date
  FROM tutorial.sf_crime_incidents_2014_01
  
--Write a query that creates an accurate timestamp using the date and time columns in tutorial.sf_crime_incidents_2014_01. Include a field that is exactly 1 week later as well.
SELECT incidnt_num,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp AS timestamp,
       (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) ||
        '-' || SUBSTR(date, 4, 2) || ' ' || time || ':00')::timestamp
        + INTERVAL '1 week' AS timestamp_plus_interval
  FROM tutorial.sf_crime_incidents_2014_01
  
SELECT cleaned_date,
       EXTRACT('year'   FROM cleaned_date) AS year,
       EXTRACT('month'  FROM cleaned_date) AS month,
       EXTRACT('day'    FROM cleaned_date) AS day,
       EXTRACT('hour'   FROM cleaned_date) AS hour,
       EXTRACT('minute' FROM cleaned_date) AS minute,
       EXTRACT('second' FROM cleaned_date) AS second,
       EXTRACT('decade' FROM cleaned_date) AS decade,
       EXTRACT('dow'    FROM cleaned_date) AS day_of_week
  FROM tutorial.sf_crime_incidents_cleandate
  
SELECT cleaned_date,
       DATE_TRUNC('year'   , cleaned_date) AS year,
       DATE_TRUNC('month'  , cleaned_date) AS month,
       DATE_TRUNC('week'   , cleaned_date) AS week,
       DATE_TRUNC('day'    , cleaned_date) AS day,
       DATE_TRUNC('hour'   , cleaned_date) AS hour,
       DATE_TRUNC('minute' , cleaned_date) AS minute,
       DATE_TRUNC('second' , cleaned_date) AS second,
       DATE_TRUNC('decade' , cleaned_date) AS decade
  FROM tutorial.sf_crime_incidents_cleandate
  
--Write a query that counts the number of incidents reported by week. Cast the week as a date to get rid of the hours/minutes/seconds.
SELECT DATE_TRUNC('week' , cleaned_date) :: date AS week, COUNT(*) AS incidents
  FROM tutorial.sf_crime_incidents_cleandate
  GROUP BY 1
  ORDER BY 1
  
SELECT CURRENT_DATE AS date,
       CURRENT_TIME AS time,
       CURRENT_TIMESTAMP AS timestamp,
       LOCALTIME AS localtime,
       LOCALTIMESTAMP AS localtimestamp,
       NOW() AS now
       
SELECT CURRENT_TIME AS time,
       CURRENT_TIME AT TIME ZONE 'EST' AS time_pst