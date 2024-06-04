#!/usr/bin/python3
"""Queries titles of the top 10 reddit posts"""

from requests import get

def top_ten(subreddit):
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {'User-agent': 'Google Chrome Version 124.0.6367.78'}

    try:
        response = get(url, headers=headers)
        top_data = response.json()
        hot_data = top_data.get('data').get('children')

        if 'error' in top_data:
            print(None)
            return

        for hots in hot_data:
            print(hots.get('data').get('title'))

    except Exception:
        print(None)
