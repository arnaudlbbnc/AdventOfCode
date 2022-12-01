import datetime
import sys
import os
import shutil
import requests

if len(sys.argv) == 2:
    dayOfMonth = sys.argv[1]
else:
    dayOfMonth = datetime.datetime.now().strftime("%d")

if dayOfMonth[0] == "0":
    dayOfMonth = dayOfMonth[1:]


# Folder creation
folderPath = os.getcwd() + "/" + dayOfMonth
if os.path.exists(folderPath):
    sys.exit("Folder already exists for the day %s. In order to continue you should delete it first !" % dayOfMonth)

try:
    os.mkdir(folderPath)
except OSError:
    sys.exit("Creation of the directory %s failed" % folderPath)


# Input GET
inputUrl = "https://adventofcode.com/2022/day/" + dayOfMonth + "/input"
sessionId = "53616c7465645f5f08c73c6961fc0e6b62e7359e893fbb348452430b319c0b032211521cc7756b9a8bc79b25f53dbdb4215a50e6d4944757932053801cc2223a"

cookies = {'session': sessionId}

response = requests.post(inputUrl, cookies=cookies)

code = response.status_code

if code == requests.codes['not_found']:
    sys.exit("The input file doesn't exist, the generation will stop.")

file = open(dayOfMonth + "/input.txt", "w+")
file.write(response.text)
file.close()

shutil.copy("day.py", dayOfMonth + "/day.py")
