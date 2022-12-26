from pathlib import Path


def coordinatesBetweenPoints(start, end):
    if start[0] == end[0]:
        if start[1] > end[1]:
            return {(start[0], i) for i in range(end[1], start[1]+1)}
        else:
            return {(start[0], i) for i in range(start[1], end[1]+1)}
    else:
        if start[0] > end[0]:
            return {(i, start[1]) for i in range(end[0], start[0]+1)}
        else:
            return {(i, start[1]) for i in range(start[0], end[0]+1)}


def createMap(rocks, part):
    minXRock = 0
    maxXRock = 1000
    minYRock = 0
    maxYRock = max([rock[1] for rock in rocks])

    map = []
    for i in range(minYRock, maxYRock+1):
        line = []
        for j in range(minXRock, maxXRock+1):
            if (j, i) in rocks:
                line.append('#')
            else:
                line.append('.')
        map.append(line)

    if part == 2:
        map.append(['.' for i in range(0, len(map[0]))])
        map.append(['#' for i in range(0, len(map[0]))])
    return map


def dropIt(map, part):
    if 'O' in map[0]:
        return False
    currentPosition = (0, 500)
    while True:
        nextCoordinateBottom = (currentPosition[0]+1, currentPosition[1])
        nextCoordinateBottomLeft = (currentPosition[0]+1, currentPosition[1]-1)
        nextCoordinateBottomRight = (currentPosition[0]+1, currentPosition[1]+1)
        if nextCoordinateBottom[0] >= len(map):
            return False
        elif map[nextCoordinateBottom[0]][nextCoordinateBottom[1]] == ".":
            currentPosition = nextCoordinateBottom
            continue
        if nextCoordinateBottomLeft[1] < 0:
            if part == 1:
                return False
            else:
                [map[i].insert(0, '.') for i in range(0, len(map))]
                map[len(map)-1][0] = "#"
                currentPosition = (nextCoordinateBottomLeft[0], nextCoordinateBottomLeft[1]+1)
                continue
        elif map[nextCoordinateBottomLeft[0]][nextCoordinateBottomLeft[1]] == ".":
            currentPosition = nextCoordinateBottomLeft
            continue
        if nextCoordinateBottomRight[1] >= len(map[0]):
            if part == 1:
                return False
            else:
                [map[i].add('.') for i in range(0, len(map))]
                currentPosition = nextCoordinateBottomRight
                continue
        elif map[nextCoordinateBottomRight[0]][nextCoordinateBottomRight[1]] == ".":
            currentPosition = nextCoordinateBottomRight
            continue
        map[currentPosition[0]][currentPosition[1]] = 'O'
        return True


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = [linesOfRocks.split(' -> ') for linesOfRocks in inputFile.read().splitlines()]
    linesOfCoordinates = []
    for input in inputs:
        linesOfCoordinates.append([(int(coordinates.split(',')[0]), int(coordinates.split(',')[1])) for coordinates in input])

    rocksCoordinates = set()
    for lineOfCoordinates in linesOfCoordinates:
        if len(lineOfCoordinates) == 1:
            rocksCoordinates.add(lineOfCoordinates[0])
        index = 0
        while index < len(lineOfCoordinates) - 1:
            rocksCoordinates = rocksCoordinates.union(coordinatesBetweenPoints(lineOfCoordinates[index], lineOfCoordinates[index+1]))
            index += 1

    map = createMap(rocksCoordinates, 1)
    sum = 0
    while dropIt(map, 1):
        sum += 1
    print(sum)

    map = createMap(rocksCoordinates, 2)
    sum = 0
    while dropIt(map, 2):
        sum += 1
    print(sum)
