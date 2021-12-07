def algoPart1(inputs):
    inputsRotated = list(zip(*reversed(inputs)))
    gammaStr = ""
    epsilonStr = ""
    for i in range(len(inputsRotated)):
        line = inputsRotated[i]
        countOne = line.count("1")
        countZero = line.count("0")
        gammaStr += "1" if countOne > countZero else "0"
        epsilonStr += "0" if countOne > countZero else "1"
    gamma = int(gammaStr, 2)
    epsilon = int(epsilonStr, 2)
    return gamma * epsilon

def algoPart2(inputs):
    binaryLength = len(inputs[0])
    oxygenInputs = inputs
    for i in range(binaryLength):
        line = list(zip(*reversed(oxygenInputs)))[i]
        countOne = line.count("1")
        countZero = line.count("0")
        mostValue = "1" if countOne >= countZero else "0"
        oxygenInputs = [input for input in oxygenInputs if input[i] == mostValue]
        if len(oxygenInputs) == 1:
            break
    carbonInputs = inputs
    for i in range(binaryLength):
        line = list(zip(*reversed(carbonInputs)))[i]
        countOne = line.count("1")
        countZero = line.count("0")
        leastValue = "0" if countOne >= countZero else "1"
        carbonInputs = [input for input in carbonInputs if input[i] == leastValue]
        if len(carbonInputs) == 1:
            break
    oxygen = int(oxygenInputs[0], 2)
    carbon = int(carbonInputs[0], 2)
    return oxygen * carbon

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()

    print(algoPart1(inputs))
    print(algoPart2(inputs))