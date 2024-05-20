#!/usr/bin/python3
"""Gather data from an API"""
import json
import requests
import sys


if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    user = requests.get(url + "users/{}".format(sys.argv[1])).json()
    username = user.get("username")
    todos = requests.get(url + "todos", params={"userId": sys.argv[1]}).json()

    tasks = []
    for x in todos:
        task = {
            "task": x.get("title"),
            "completed": x.get("completed"),
            "username": username
        }
        tasks.append(task)

    data = {sys.argv[1]: tasks}

    with open("{}.json".format(sys.argv[1]), "w") as jsonfile:
        json.dump(data, jsonfile)
