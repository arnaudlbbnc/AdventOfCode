import re

inputFile = open('input.txt', 'r') 
inputs = inputFile.readlines()

class LinePartOne:
    def __init__(self, min, max, character, password):
        self.min = min
        self.max = max
        self.character = character
        self.password = password

    def isValid(self):
        nbOccurences = self.password.count(self.character)
        return self.min <= nbOccurences <= self.max

def getLinesPartOne():
    lines = []
    for input in inputs:
        res = re.search(r'(\d+)-(\d+)\s(\w):\s(\w+)', input)
        min = int(res.group(1))
        max = int(res.group(2))
        character = res.group(3)
        password = res.group(4)
        line = LinePartOne(min, max, character, password)
        lines.append(line)
    return lines

def algoPart1():
    count = 0
    for line in getLinesPartOne():
        count += 1 if line.isValid() else 0
    return count

class LinePartTwo:
    def __init__(self, firstPosition, secondPosition, character, password):
        self.firstPosition = firstPosition
        self.secondPosition = secondPosition
        self.character = character
        self.password = password

    def isValid(self):
        return bool(self.password[self.firstPosition-1] == self.character) ^ bool(self.password[self.secondPosition-1] == self.character)

def getLinesPartTwo():
    lines = []
    for input in inputs:
        res = re.search(r'(\d+)-(\d+)\s(\w):\s(\w+)', input)
        firstPosition = int(res.group(1))
        secondPosition = int(res.group(2))
        character = res.group(3)
        password = res.group(4)
        line = LinePartTwo(firstPosition, secondPosition, character, password)
        lines.append(line)
    return lines

def algoPart2():
    count = 0
    for line in getLinesPartTwo():
        count += 1 if line.isValid() else 0
    return count

print(algoPart1())
print(algoPart2())