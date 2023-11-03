import json
import datetime
import os
import requests
import shutil
import sys

today = datetime.date.today()
day = today.day
month = today.month
year = 2023
 

# Folder creation
filePath = os.getcwd() + "/dataviz/leaderboard/" + str(day) + "-" + str(month) + ".json"

# Input GET
leaderboardId = os.environ.get('aocLeaderboardId', 'leaderboard')
inputUrl = "https://adventofcode.com/{year}/leaderboard/private/view/{leaderboardId}.json".format(year=str(year), leaderboardId=leaderboardId)
session = os.environ.get('aocSession', 'session')
cookies = {'session': session}

response = requests.get(inputUrl, cookies=cookies)

code = response.status_code

if code == requests.codes['not_found']:
    sys.exit("The leaderboard file doesn't exist, the generation will stop.")

data = response.json()
print(data)
with open(filePath, "w") as file:
    json.dump(data , file)
