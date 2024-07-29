/*
Exploratory Data Analysis
1. General Distributions
2. Top 10 Youtubers with
	a. View count
	b. Subscriber count
	c. Views per video (engagement rate)
3. Countries with
	a. Highest engagement rate 
	b. Number of active youtubers

*/

-- GENERAL DISTRIBUTIONS
SELECT 
    localization AS country,
    COUNT(*) AS counts,
	ROUND((CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM youtube_data_scandi) * 100), 1) AS ratio 
FROM youtube_data_scandi
GROUP BY localization
ORDER BY counts DESC;

-- Top 10 Youtubers with highest viewers
SELECT title, view_count 
FROM youtube_data_scandi
ORDER BY view_count DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- Top 10 Youtubers with highest subscriber counts
SELECT title, subscriber_count 
FROM youtube_data_scandi
ORDER BY subscriber_count DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- TOP 10 Youtubers with highest engagement rate
SELECT 
	title, 
	COALESCE(view_count / NULLIF(video_count,0), 0) AS engagement_rate
FROM youtube_data_scandi
ORDER BY engagement_rate DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY

-- Regions with highest engagement rate
SELECT 
	localization, 
	SUM(video_count) AS videos,
	SUM(view_count) / SUM(video_count) AS region_eng_rate
FROM youtube_data_scandi
GROUP BY localization
ORDER BY region_eng_rate DESC, videos DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;