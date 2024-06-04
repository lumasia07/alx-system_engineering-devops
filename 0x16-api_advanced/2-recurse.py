#!/usr/bin/python3
"""Queries Reddit API recursively"""

from requests import get


def recurse(subreddit, hot_list=[]):
    url = "https://www.reddit.com/r/{}/hot.json?limit=100"
    headers = {'User-Agent': 'Google Chrome Version 124.0.6367.78'}

    try:
        response = get(url, headers=headers)
        data = response.json()

        if 'error' in data:
            return None

        hot_posts = data['data']['children']

        for post in hot_posts:
            hot_list.append(post['data']['title'])

        after = data['data']['after']

        if after:
            return recurse(subreddit, hot_list)
        else:
            return hot_list

    except Exception:
        return None
