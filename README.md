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



