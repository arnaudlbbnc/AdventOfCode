from pathlib import Path
import re


def directionValue(direction):
    if direction == ">":
        return 0
    elif direction == "v":
        return 1
    elif direction == "<":
        return 2
    elif direction == "^":
        return 3


def changeDirection(oldDirection, turn):
    if oldDirection == ">":
        if turn == "R":
            return "v"
        return "^"
    elif oldDirection == "v":
        if turn == "R":
            return "<"
        return ">"
    elif oldDirection == "<":
        if turn == "R":
            return "^"
        return "v"
    elif oldDirection == "^":
        if turn == "R":
            return ">"
        return "<"


def extractColumn(map, columnIndex):
    return list(zip(*map))[columnIndex]


def calculateNextCoordinate(map, direction, coordinate):
    lineLen = len(map[coordinate[1]])
    if direction == ">":
        lastIndexNotWhitespace = lineLen - 1 - [m.span()[0] for m in re.finditer('\.|#', ''.join(map[coordinate[1]][::-1]))][0]
        if lastIndexNotWhitespace == coordinate[0]:
            firstIndexNotWhitespace = [m.span()[0] for m in re.finditer('\.|#', ''.join(map[coordinate[1]]))][0]
            return (firstIndexNotWhitespace, coordinate[1])
        else:
            return (coordinate[0]+1, coordinate[1])
    elif direction == "v":
        column = extractColumn(map, coordinate[0])
        lastIndexNotWhitespace = len(column) - 1 - [m.span()[0] for m in re.finditer('\.|#', ''.join(column[::-1]))][0]
        if lastIndexNotWhitespace == coordinate[1]:
            firstIndexNotWhitespace = [m.span()[0] for m in re.finditer('\.|#', ''.join(column))][0]
            return (coordinate[0], firstIndexNotWhitespace)
        else:
            return (coordinate[0], coordinate[1]+1)
    elif direction == "<":
        firstIndexNotWhitespace = [m.span()[0] for m in re.finditer('\.|#', ''.join(map[coordinate[1]]))][0]
        if firstIndexNotWhitespace == coordinate[0]:
            lastIndexNotWhitespace = lineLen - 1 - [m.span()[0] for m in re.finditer('\.|#', ''.join(map[coordinate[1]][::-1]))][0]
            return (lastIndexNotWhitespace, coordinate[1])
        else:
            return (coordinate[0]-1, coordinate[1])
    elif direction == "^":
        column = extractColumn(map, coordinate[0])
        firstIndexNotWhitespace = [m.span()[0] for m in re.finditer('\.|#', ''.join(column))][0]
        if firstIndexNotWhitespace == coordinate[1]:
            lastIndexNotWhitespace = len(column) - 1 - [m.span()[0] for m in re.finditer('\.|#', ''.join(column[::-1]))][0]
            return (coordinate[0], lastIndexNotWhitespace)
        else:
            return (coordinate[0], coordinate[1]-1)


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().split('\n\n')
    inputMap = [list(line) for line in inputs[0].splitlines()]
    inputPath = inputs[1]

    maxColumns = max([len(line) for line in inputMap])
    firstLineMaxSize = list(filter(lambda line: len(line) == maxColumns, inputMap))[0]

    for line in inputMap:
        line.extend(' '*(maxColumns-len(line)))

    currentDirection = ">"
    currentCoordinate = (inputMap[0].index('.'), 0)
    turns = re.findall(r'(R|L)+', inputPath)
    steps = [int(step) for step in re.findall(r'\d+', inputPath)]
    for i in range(len(turns)+len(steps)):
        if i % 2 == 0:
            step = steps[int(i/2)]
            for j in range(step):
                nextCoordinate = calculateNextCoordinate(inputMap, currentDirection, currentCoordinate)
                if inputMap[nextCoordinate[1]][nextCoordinate[0]] == '.':
                    currentCoordinate = nextCoordinate
                else:
                    break
        else:
            turn = turns[int((i-1)/2)]
            currentDirection = changeDirection(currentDirection, turn)

    password = 1000 * (currentCoordinate[1]+1) + 4 * (currentCoordinate[0]+1) + directionValue(currentDirection)
    print(password)
