# Data Project: MSSQL to Power BI Dashboard

<p align="center">
  <img src="https://i.pinimg.com/originals/f9/fd/ee/f9fdee9073b6b6c4ade999a359fbd012.gif">
</p>


## Objective | User Story
Company XYZ launched in Sweden wants to run a totally new and potentially profitable marketing campaign on Scandii Youtubers.
The question was clearly stated during the first meeting of CMO and Marketing Analysts.
* What is the solution?

Based on the request, analysts decided to create a PBI dashboard that can help the company with decision making using engagement metrics such as
* Total Views
* Subscriber Count
* Views per Video
* Views per Subscriber
* etc.

## Prerequisites 
First of all, we need a dataset containing all the metrics mentioned above. Company provided us with four messy datasets for each according region as shown below:

![image](https://github.com/user-attachments/assets/2128c927-d958-4dd6-ad2f-a457f5f73c7a)

We tried to perform some feature engineering with the variables, but we were not satisfied with the results. So the question was opened.

## Project Process Overview

<table>
  <tr>
    <td>Project Step</td>
    <td>Step Overview</td>
    <td>Tools</td>
  </tr>
  <tr>
    <td>Dataset Creation</td>
    <td>Using YouTube API enabled us to extract all necessary information about the YouTuber ID and save it into new CSV file</td>
    <td>Python, YouTube API</td>
  </tr>
  <tr>
    <td>Dataset Quality Assurance</td>
    <td>Perform data quality checks and data analysis with the dataset</td>
    <td>SQL</td>
  </tr>
  <tr>
    <td>Dashboard Development</td>
    <td>Create interactive dashboard using PBI to answer important questions</td>
    <td>Power BI</td>
  </tr>
  <tr>
    <td>Recommendations</td>
    <td>Calculate potential ROI and provide top 5 Youtubers on whom marketing campaign should be ran to maximize revenue</td>
    <td>Excel, SQL</td>
  </tr>


## Dataset Creation

* Create datasets containing most watched youtubers from Denmark, Sweden, Norway, and Finland. 

Using Python we could easily approach the goal of the task:

* Load datasets and extract only channel IDs from the NAME column and save them in Python list

![image](https://github.com/user-attachments/assets/f57e5220-16e5-4189-a7a4-6d22815ce813)
Only one column provided us with the valuable features for ETL process.

* Implement function that uses the YouTube Data API to fetch details about a specific channel, including its snippet (title, country) and statistics (view count, subscriber count, video count)

![image](https://github.com/user-attachments/assets/facf0547-7df6-4c83-9d78-22c6306d058d)

* Implement function that executes all the fetching process across all YouTube IDs

![image](https://github.com/user-attachments/assets/0414b661-a697-470d-b223-22e5e88780f6)

**Output** of the step is a complete CSV file containing
* Channel Name
* Channel Localization
* Number of Subscribers
* Number of Views
* Number of Videos
  
![image](https://github.com/user-attachments/assets/4935e37b-e4ed-41f6-abdd-e5840756b17a)


## Data Quality Assurance 
At that standpoint, dataset is considered complete, but before processing to dashboard development, we have to ensure that the quality of data is fit with our exepctations. 
So data must be explored on anomalies (missing values, duplicates, outliers). Either SQL or Python is used to perform data quality check.

What kind of checks should be performed:
* Row-column count 
* Data type 
* Duplicates
* Missing values

![image](https://github.com/user-attachments/assets/36bdc89e-3c25-43df-87f0-045745796fc0)

As a result, all 4 data quality tests were passed:

<table>
  <tr>
    <td>Column numbers</td>
    <td>5</td>
  </tr>
  <tr>
    <td>Entry (row) numbers</td>
    <td>385</td>
  </tr>
  <tr>
    <td>Duplicates</td>
    <td>0</td>
  </tr>
  <tr>
    <td>Null values</td>
    <td>0</td>
  </tr>

## Data Analysis using SQL
Exploratory Data Analysis was conducted to address the problem of the task.

#### General Distribution

**Distribution of Youtubers across regions**

![image](https://github.com/user-attachments/assets/2c64c1a1-97ee-4c91-94f2-33ea068312fa)

**Results**
* Finland: 95 (24.68%)
* Denmark: 90 (23.34%)
* Sweden: 90 (23.34%)
* Norway: 88 (22.86%)

Other Youtubers were spread across other countries such as US, UAE, GB, etc. indicating that Youtubers had moved to another region.


**Youtubers with highest number of views and subscribers**

![image](https://github.com/user-attachments/assets/6d7b6f39-6b30-43b1-8528-8921f600a1ad)

**Results**
Following Youtubers had highest **NUMBER OF VIEWS**:

* Alan Walker	14.4 billion
* Avicii	11.01 billion
* Hydraulic Press Channel	5.25 billion
* ABBA	4.71 billion
* Soothing Relaxation	4.18 billion
* Zara Larsson	3.25 billion
* Rabbert	3.17 billion
* Brawl Stars	2.63 billion
* Levinho	2.46 billion
* Roxette	2.42 billion

YouTubers listed above gathered substantial attention, with view counts ranging from 2 billion to 14.4 billion. These channels are likely major influencers.

Youtubers with highest **ENGAGEMENT RATE**
From that standpoint, we will consider engagement rate metrics as the most important ones as they clearly indicate channel's future possibility to attract sales from the marketing campaign.
*Engagement rate metrics are ratios between views, subscribers and videos count.*

![image](https://github.com/user-attachments/assets/32e5ec73-3a2f-475f-9590-30e48d212a9b)

Regions with highest **VIEWS PER VIDEO**

Sweden:	925179
Norway:	596256
Finland: 590935
Denmark: 279955

Sweden has the highest engagement rate, with 925 thousand views per video, suggesting that content from Swedisg YouTubers is particularly popular. Norway and Finland have almost similar average engagement metrics of 590 thousand views per video, and Denmark has significantly lower engagement rate compared to other three Scandinavian regions indicating that Danish Youtubers are least popular.
P.S. number of uploaded videos across all 4 regions are similar with relatively small difference.

## Power BI Visualizations
Even though conducted analysis in SQL provided us valuable insights, from user experience perspective dashboards offer dynamic and interactive representation of data clearly indicating patterns and trends visually instead of sometimes complicated table charts.

![image](https://github.com/user-attachments/assets/b11e7814-d62f-4795-91a6-8b043518d945)

Six DAX Measures were used in dashboard

* **Total Views**:
```Total Views (B) = 
var totalViews = sum(youtube_data_scandi[view_count])
var billion = 1000000000
var totalViewsB = DIVIDE(totalViews, billion)
return totalViewsB```
