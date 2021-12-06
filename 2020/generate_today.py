import datetime, sys, os, shutil, requests

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


#Input GET
inputUrl = "https://adventofcode.com/2020/day/" + dayOfMonth + "/input"
sessionId = "53616c7465645f5fd0fb6f6d1bfec33f82a8b7d55be5b51a5bd122dc3f6ec1e9a76d0b8c43a94462c591cfff680095b9"

cookies = {'session': sessionId}

response = requests.post(inputUrl, cookies=cookies)

code = response.status_code

if code == requests.codes['not_found']:
    sys.exit("The input file doesn't exist, the generation will stop.")

file = open(dayOfMonth + "/input.txt", "w+")
file.write(response.text)
file.close()

shutil.copy("day.py", dayOfMonth + "/day.py")