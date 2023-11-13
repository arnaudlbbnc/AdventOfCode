import json
import datetime
import os

class Member:
    def __init__(self, id, aocUsername, firstname, lastname, localScore, stars, timestamps, agency):
        self.id = id
        self.aocUsername = aocUsername
        self.firstname = firstname
        self.lastname = lastname
        self.localScore = localScore
        self.stars = stars
        self.timestamps = timestamps
        self.agency = agency

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
year = today.year
aocYear = os.environ.get('aocYear', '2023')

filePathLeaderboard = "{base}/dataviz/leaderboard/{aocYear}/{day}-{month}.json".format(base=os.getcwd(), aocYear=aocYear, day=day, month=month)
fileLeaderboard = open(filePathLeaderboard)
dataLeaderboard = json.load(fileLeaderboard)

filePathSfeir = "{base}/dataviz/leaderboard/{aocYear}/sfeir.json".format(base=os.getcwd(), aocYear=aocYear)
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
    member = Member(memberId, dataMemberLeaderboard['name'], dataMemberSfeir['firstname'], dataMemberSfeir['lastname'], dataMemberLeaderboard['local_score'], dataMemberLeaderboard['stars'], timestamps, dataMemberSfeir['agency'])
    formattedMembers.append(member)

filePath = "{base}/dataviz/leaderboard/{aocYear}/formatted/{year}-{month}-{day}.json".format(base=os.getcwd(), aocYear=aocYear,year=year, month=month, day=day)
with open(filePath, "w") as file:
    json.dump([m.__dict__ for m in formattedMembers] , file)
