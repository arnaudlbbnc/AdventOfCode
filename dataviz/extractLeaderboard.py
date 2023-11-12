import json
import datetime
import os
import requests
import sys

today = datetime.date.today()
day = today.day
month = today.month
 
leaderboardId = os.environ.get('aocLeaderboardId', 'leaderboard')
year = os.environ.get('aocYear', '2023')
inputUrl = "https://adventofcode.com/{year}/leaderboard/private/view/{leaderboardId}.json".format(year=year, leaderboardId=leaderboardId)
session = os.environ.get('aocSession', 'session')
cookies = {'session': session}

response = requests.get(inputUrl, cookies=cookies)

code = response.status_code

if code == requests.codes['not_found']:
    sys.exit("The leaderboard file doesn't exist, the generation will stop.")

data = response.json()

filePath = "{base}/dataviz/leaderboard/{year}/{day}-{month}.json".format(base=os.getcwd(), year=year, day=day, month=month)
with open(filePath, "w") as file:
    json.dump(data , file)
