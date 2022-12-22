from pathlib import Path
import copy
import time


class Cube:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def isAdjacentToOne(self, other):
        return (abs(self.x - other.x) + abs(self.y - other.y) + abs(self.z - other.z)) == 1
    
    def isAdjacentToMultiple(self, others):
        for other in others:
            if self.isAdjacentToOne(other):
                return True
        return False

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y and self.z == other.z
    
    def __repr__(self):
        return ", ".join([str(self.x), str(self.y), str(self.z)])
    
    def __hash__(self):
        return hash(repr(self))

    def adjacentCubes(self):
        return [Cube(self.x - 1, self.y, self.z),
                Cube(self.x + 1, self.y, self.z),
                Cube(self.x, self.y - 1, self.z),
                Cube(self.x, self.y + 1, self.z),
                Cube(self.x, self.y, self.z - 1),
                Cube(self.x, self.y, self.z + 1)]
        
def calculateSurface(cubes):
    surface = 0
    for cube in cubes:
        cubeAdjacentSides = 0
        for otherCube in cubes:
            if cube.isAdjacentToOne(otherCube):
                cubeAdjacentSides += 1
        surface += 6 - cubeAdjacentSides
    return surface

def zMatrix(z, cubes):
    matrix = []
    for x in range(0, 21):
        listX = []
        for y in range(0, 20):
            if Cube(x, y, z) in cubes:
                listX.append('#')
            else:
                listX.append('.')
        matrix.append(listX)
    return matrix

def printCubesAtZ(z, cubes):
    representation = ''
    for x in range(0, 21):
        for y in range(0, 20):
            if Cube(x, y, z) in cubes:
                representation += '#'
            else:
                representation += '.'
        representation += '\n'
    print(representation)
    # time.sleep(0.5)


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = [str.split(',') for str in inputFile.read().splitlines()]
    cubes = []
    for input in inputs:
        cubes.append(Cube(int(input[0]), int(input[1]), int(input[2])))

    surface = calculateSurface(cubes)
    print(surface)
    
    
    minZ = min([cube.z for cube in cubes])
    maxZ = max([cube.z for cube in cubes])
    cubesOfAir = []
    for z in range(0, 20):
        cubesAtZ = list(filter(lambda cube: cube.z == z, cubes))
        printCubesAtZ(z, cubesAtZ)
        if z != 19:
            print("\033[F"*23)
        elif z == 19:
            a = 1
        if len(cubesAtZ) == 0:
            continue
        matrix = zMatrix(z, cubesAtZ)
        matrixRotated = list(zip(*matrix))
        cubesInvalid = []
        for x in range(0, 20):
            for y in range(0, 20):
                if matrix[x][y] == "#":
                    continue
                cube = Cube(x, y, z)
                rockOnLeft = False if x == 0 else matrix[x-1][y] == "#"
                rockOnRight = False if x == len(matrix)-1 else matrix[x+1][y] == "#"
                rockOnTop = False if y == 0 else matrix[x][y-1] == "#"
                rockOnBottom = False if y == len(matrix[x])-1 else matrix[x][y+1] == "#"
                rockAbove = False if z == 0 else zMatrix(z-1, list(filter(lambda cube: cube.z == z-1, cubes))) == "#"
                rockBelow = False if z == 19 else zMatrix(z+1, list(filter(lambda cube: cube.z == z+1, cubes))) == "#"
                rockAround = rockOnLeft or rockOnRight or rockOnTop or rockOnBottom or rockAbove or rockBelow
                if cube not in cubes and not cube.isAdjacentToMultiple(cubesInvalid) and rockAround:# and "#" in matrix[x][:y] and "#" in matrix[x][y:] and "#" in matrixRotated[y][:x] and "#" in matrixRotated[y][x:]:
                    cubesOfAir.append(cube)
                elif cube not in cubes:
                    cubesInvalid.append(cube)
    
    realSurface = surface - (calculateSurface(cubesOfAir))
    print(realSurface)

# IDEA
# Use Djikstra but in 3D
# Start from 0, 0
# Continue if not rock
# We got cubes with air
# We find the ones adjacent to rocks and how much they are (how many sides)
# We substract it to surface