import os
from typing import List, Dict, Optional, Union
import pandas as pd
from googleapiclient.discovery import build


YOUTUBE_API_KEY = os.environ.get("YOUTUBE_API_KEY")

# Extract ID of Youtubers from four CSV datasets
def extract_only_id() -> List[str]:
    countries = ["denmark", "finland", "sweden", "norway"]
    channel_ids = []

    for idx, country in enumerate(countries, start=1):
        df = pd.read_csv(f"../data/youtube_data_{country}.csv")
        channel_ids.extend(df.iloc[:, 1].str.split("@").str[-1].unique())

    return channel_ids

# Extract all necessary channel information  using YouTube API
def get_channel_info(channel_id: str) -> Optional[Dict[str, Union[List, str]]]:
    youtube = build("youtube", "v3", developerKey=YOUTUBE_API_KEY)
    
    request = youtube.channels().list(
        part="snippet, statistics",
        id=channel_id
    )

    try:
        response = request.execute()
        if response and "items" in response and len(response["items"]) > 0:
            return response
    except Exception as e:
        print(e)
    
    return None

# Execute extraction process for all YT IDs
def execute_extraction() -> None:
    channel_ids = extract_only_id()
    result = []

    for idx, id in enumerate(channel_ids, start=1):
        channel_info = get_channel_info(id)

        if channel_info:
            channel_item = channel_info["items"][0] 
            result_info = {
                "title": channel_item["snippet"]["title"],
                "localization": channel_item["snippet"]["country"],
                "view_count": channel_item["statistics"]["viewCount"],
                "subscriber_count": channel_item["statistics"]["subscriberCount"],
                "video_count": channel_item["statistics"]["videoCount"]
            }
            result.append(result_info)
    
    data = pd.DataFrame(result).reset_index(drop=True)
    data.to_csv("youtube_data_scandi.csv", index=False)
        
def main():
    execute_extraction()



if __name__ == "__main__":
    main()