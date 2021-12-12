from collections import Counter

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __str__(self):
        return str(self.x) + "," + str(self.y)

    def __repr__(self):
        return str(self)

    def __hash__(self):
        return hash(str(self))

    @classmethod
    def fromRaw(cls, raw):
        coordinates = raw.split(',')
        return cls(int(coordinates[0]), int(coordinates[1]))

class Vector:
    def __init__(self, pointA, pointB):
        self.pointA = pointA
        self.pointB = pointB

    def determinePoints(self, withDiagonal):
        points = [self.pointA, self.pointB]
        if self.pointA.x == self.pointB.x:
            start = self.pointA.y+1 if self.pointA.y < self.pointB.y else self.pointB.y + 1
            end = self.pointB.y if self.pointA.y < self.pointB.y else self.pointA.y
            for y in range(start, end):
                points.append(Point(self.pointA.x, y))
        elif self.pointA.y == self.pointB.y:
            start = self.pointA.x+1 if self.pointA.x < self.pointB.x else self.pointB.x + 1
            end = self.pointB.x if self.pointA.x < self.pointB.x else self.pointA.x
            for x in range(start, end):
                points.append(Point(x, self.pointA.y))
        else:
            if withDiagonal:
                xShouldIncrement = self.pointA.x < self.pointB.x
                yShouldIncrement = self.pointA.y < self.pointB.y
                currentX = self.pointA.x
                currentY = self.pointA.y
                for x in range(0, abs(self.pointA.x-self.pointB.x)-1):
                    currentX = currentX + (1 if xShouldIncrement else -1)
                    currentY = currentY + (1 if yShouldIncrement else -1)
                    points.append(Point(currentX , currentY))
            else:
                points = []
        return points

def algoPart1(vectors):
    allPoints = [point for vector in vectors for point in vector.determinePoints(withDiagonal=False)]
    counter = Counter(allPoints)
    return len(dict(filter(lambda x: x[1] > 1, counter.items())))
    
def algoPart2(vectors):
    allPoints = [point for vector in vectors for point in vector.determinePoints(withDiagonal=True)]
    counter = Counter(allPoints)
    return len(dict(filter(lambda x: x[1] > 1, counter.items())))

def formatVector(input):
    pointsRaw = input.split(' -> ')
    return Vector(Point.fromRaw(pointsRaw[0]), Point.fromRaw(pointsRaw[1]))

if __name__ == "__main__":
    inputFile = open('/Users/arnaudlebourblanc/Documents/workspace/Arnaud/AdventOfCode/2021/5/input.txt', 'r')
    inputs = inputFile.read().splitlines()
    vectors = [formatVector(input) for input in inputs]

    print(algoPart1(vectors))
    print(algoPart2(vectors))