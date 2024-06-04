#!/usr/bin/python3
"""Queries titles of the top 10 reddit posts"""

import requests

def top_ten(subreddit):
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {'User-Agent': 'Google Chrome Version 124.0.6367.78'}

    try:
        response = requests.get(url, headers=headers)
        top_data = response.json()
        hot_data = top_data.get('data').get('children')

        if 'error' in data:
            print(None)
            return

        for hots in hot_data:
            print(hots.get('data').get('title'))

    except Exception:
        print(None)
