import json
import datetime
import os

today = datetime.date.today()
day = today.day
month = today.month

year = os.environ.get('aocYear', '2023')
filePathLeaderboard = "{base}/dataviz/leaderboard/{year}/{day}-{month}.json".format(base=os.getcwd(), year=year, day=day, month=month)
fileLeaderboard = open(filePathLeaderboard)
dataLeaderboard = json.load(fileLeaderboard)

filePathSfeir = "{base}/dataviz/leaderboard/{year}/sfeir.json".format(base=os.getcwd(), year=year)
fileSfeir = open(filePathSfeir)
dataSfeir = json.load(fileSfeir)

dataMembersLeaderboard = dataLeaderboard['members']
missingMemberFound = False
for memberId in dataMembersLeaderboard:
    if memberId not in dataSfeir:
        missingMemberFound = True
        print("{id} - {name} not in Sfeir list".format(id=memberId, name=dataMembersLeaderboard[memberId]['name']))

if missingMemberFound == False:
    print('Looks like everyone is registered into the "database"')