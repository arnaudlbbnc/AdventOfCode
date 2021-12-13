def locationIsLow(grid, x, y, topless = False, bottomless = False, leftless = False, rightLess = False):
    location = grid[x][y]
    if x > 0:
        top = grid[x-1][y]
        if location >= top:
            return False
    if x < len(grid)-1:
        bottom = grid[x+1][y]
        if location >= bottom:
            return False
    if y > 0:
        left = grid[x][y-1]
        if location >= left:
            return False
    if y < len(grid[x])-1:
        right = grid[x][y+1]
        if location >= right:
            return False
    return True

def determineSizeBasin(grid, x, y):
    location = int(grid[x][y])
    if location == 9:
        return 0
    grid[x][y] = "9"
    size = 1
    if x > 0:
        top = int(grid[x-1][y])
        if location < top:
            size += determineSizeBasin(grid, x-1, y)
    if x < len(grid)-1:
        bottom = int(grid[x+1][y])
        if location < bottom:
            size += determineSizeBasin(grid, x+1, y)
    if y > 0:
        left = int(grid[x][y-1])
        if location < left:
            size += determineSizeBasin(grid, x, y-1)
    if y < len(grid[x])-1:
        right = int(grid[x][y+1])
        if location < right:
            size += determineSizeBasin(grid, x, y+1)
    return size

def algoPart1(grid):
    totalRisk = 0
    for x in range(len(grid)):
        for y in range(len(grid[0])):
            if locationIsLow(grid, x, y):
                location = grid[x][y]
                totalRisk += int(location) + 1
    return totalRisk

def algoPart2(grid):
    basins = []
    for x in range(len(grid)):
        for y in range(len(grid[0])):
            if locationIsLow(grid, x, y):
                basins.append(determineSizeBasin(grid, x, y))
    basins.sort(reverse= True)    
    return basins[0] * basins[1] * basins[2]

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsNum = [list(input) for input in inputs]

    print(algoPart1(inputsNum))
    print(algoPart2(inputsNum))