#!/usr/bin/python3
"""Get the number of subs"""

import requests


def number_of_subscribers(subreddit):
    """Queries reddit API to get number of subs"""

    url = "https://reddit.com/r/{}/about.json".format(subreddit)
    headers = {'User-agent': 'Google Chrome Version 124.0.6367.78'}

    try:
        response = requests.get(url, headers=headers)
        data = response.json()

        if 'error' in data:
            return 0

        return data['data']['subscribers']

    except Exception:
        return 0
