/* SQL code to validate calculation we made in the excel document */

-- Variable Declaration
DECLARE @conversion FLOAT = 0.001;		-- Conversion rate 0.1%
DECLARE @productCost MONEY = 5.0;			-- Product cost 5 USD
DECLARE @campaignCost MONEY = 50000.0;	-- Campaign cost 50k USD

-- Calculate Necessary Metrics
WITH ChannelData AS (
	SELECT 
		title,
		view_count,
		video_count,
		ROUND(CAST(view_count AS FLOAT) / NULLIF(video_count, 0), -4) AS views_per_video
	FROM 
		scandi_youtubers.dbo.youtube_data_scandi
)

-- Final ROI Calculations for VALIDATION 
SELECT 
	title,
	views_per_video,
	(views_per_video * @conversion) AS potential_product_sales,
	(views_per_video * @conversion * @productCost) AS potential_revenue,
	(views_per_video * @conversion * @productCost) - @campaignCost AS net_profit
FROM 
	ChannelData
WHERE 
	title IN ('Alan Walker', 'Avicii', 'Narins Beauty', 'Levinho', 'Rabbert')
ORDER BY 4 DESC;