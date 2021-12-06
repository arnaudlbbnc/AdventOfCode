import math
from collections import defaultdict

class Place:
    def __init__(self, binary):
        self.binary = binary
        self.rowBinary = binary[:7]
        self.row = self.calculateRow()
        self.columnBinary = binary[-3:]
        self.column = self.calculateColumn()


    @property
    def id(self):
        return self.row * 8 + self.column
        
    def calculateRow(self):
        return self.decryptBinary(self.rowBinary, 0, 127, 'F', 'B')

    def calculateColumn(self):
        return self.decryptBinary(self.columnBinary, 0, 7, 'L', 'R')

    def decryptBinary(self, binary, min, max, lowerChar, upperChar, index = 0):
        if min == max:
            return min
        half = math.ceil((max - min) / 2)
        if binary[index] == lowerChar:
            max -= half
        else:
            min += half
        index += 1
        return self.decryptBinary(binary, min, max, lowerChar, upperChar, index)

class Plane:
    def __init__(self, places):
        self.places = places

    def getEmptyPlaceId(self):
        columnsNb = [0,1,2,3,4,5,6,7]
        orderedPlaces = defaultdict(list)
        for place in self.places:
            orderedPlaces[place.row].append(place)
        for row, places in orderedPlaces.items():
            if len(places) == 8 or row == 0 or row == 127:
                continue
            placesColumn = list(map(lambda place: place.column, places))
            missingPlaceColumn = list(filter(lambda column: column not in placesColumn, columnsNb))[0]
            return row * 8 + missingPlaceColumn
        return 0


def parsePlaces():
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    return list(map(lambda input: Place(input), inputs))

def algoPart1(places):
    return max(place.id for place in places)

def algoPart2(places):
    plane = Plane(places)
    return plane.getEmptyPlaceId()


if __name__ == "__main__":
    places = parsePlaces()

    print(algoPart1(places))
    print(algoPart2(places))