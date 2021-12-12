def algoPart1(crabsPositions):
    positions = range(0, max(crabsPositions))
    fuel = {}
    for position in positions:
        if position in fuel:
            continue
        fuel[position] = calculateFuel(position, crabsPositions)
    return fuel[min(fuel, key=fuel.get)]

def algoPart2(crabsPositions):
    positions = range(0, max(crabsPositions))
    fuel = {}
    for position in positions:
        if position in fuel:
            continue
        fuel[position] = calculateComplexFuel(position, crabsPositions)
    return fuel[min(fuel, key=fuel.get)]

def calculateFuel(position, crabsPosition):
    return sum([abs(position - crabPosition) for crabPosition in crabsPosition])

def calculateComplexFuel(position, crabsPosition):
    def calculateCrabFuel(position, crabPosition):
        difference = abs(position - crabPosition)
        return sum([pos for pos in range(0, difference+1)])

    fuel = 0
    for crabPosition in crabsPosition:
        fuel += calculateCrabFuel(position, crabPosition)

    return fuel

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsNum = [int(str) for str in inputs[0].split(',')]

    print(algoPart1(inputsNum))
    print(algoPart2(inputsNum))