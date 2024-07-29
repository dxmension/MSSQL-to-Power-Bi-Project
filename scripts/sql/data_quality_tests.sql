/*
Data Quality Tests (5 steps)

1. Row count check
2. Column count check
3. Datatype check
4. Duplicate check
5. Null values check

*/

-- Row Count Check
SELECT COUNT(*) AS no_rows
FROM youtube_data_scandi;

-- Column Count Check
SELECT COUNT(*) AS no_columns 
FROM INFORMATION_SCHEMA.COLUMNS;

-- Data Type Check
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'youtube_data_scandi';

-- Duplicate Check
SELECT COUNT(*) AS no_duplicates
FROM youtube_data_scandi
GROUP BY title
HAVING COUNT(*) > 1;

-- Missing value check
SELECT * 
FROM youtube_data_scandi
WHERE 
	title IS NULL OR
	localization IS NULL OR
	view_count IS NULL OR
	subscriber_count IS NULL OR
	video_count IS NULL;