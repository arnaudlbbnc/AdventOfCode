import json
import datetime
import os

today = datetime.date.today()
day = today.day
month = today.month

filePathLeaderboard = os.getcwd() + "/dataviz/leaderboard/" + str(day) + "-" + str(month) + ".json"
fileLeaderboard = open(filePathLeaderboard)
dataLeaderboard = json.load(fileLeaderboard)

filePathSfeir = os.getcwd() + "/dataviz/leaderboard/sfeir.json"
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