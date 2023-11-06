import json
import datetime
import os

class Member:
    def __init__(self, id, aocUsername, firstname, lastname, localScore, stars, timestamps):
        self.id = id
        self.aocUsername = aocUsername
        self.firstname = firstname
        self.lastname = lastname
        self.localScore = localScore
        self.stars = stars
        self.timestamps = timestamps

def extractTimestamps(day):
    timestamps = []
    if '1' in day:
        timestamps.append(day['1']['get_star_ts'])
    if '2' in day:
        timestamps.append(day['2']['get_star_ts'])
    return timestamps

def extractAllTimeStamps(days):
    daysTimestamps = {}
    for day in days:
        daysTimestamps[day] = extractTimestamps(days[day])
    return daysTimestamps

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
formattedMembers = []
for memberId in dataSfeir:
    if memberId not in dataMembersLeaderboard:
        print("{id} - {name} in Sfeir list but not in AoC list".format(id=memberId, name=dataSfeir[memberId]['name']))
        continue
    dataMemberLeaderboard = dataMembersLeaderboard[memberId]
    dataMemberSfeir = dataSfeir[memberId]

    timestamps = extractAllTimeStamps(dataMemberLeaderboard['completion_day_level'])
    member = Member(memberId, dataMemberLeaderboard['name'], dataMemberSfeir['firstname'], dataMemberSfeir['lastname'], dataMemberLeaderboard['local_score'], dataMemberLeaderboard['stars'], timestamps)
    formattedMembers.append(member)

filePath = os.getcwd() + "/dataviz/leaderboard/" + str(day) + "-" + str(month) + "_formatted.json"
with open(filePath, "w") as file:
    json.dump([m.__dict__ for m in formattedMembers] , file)