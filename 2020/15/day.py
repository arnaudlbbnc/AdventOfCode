def algo(inputs, index):
    spoken = {}
    for i in range(len(inputs)):
        spoken[inputs[i]] = (i+1, 0)
    lastSpoken = inputs[-1]
    turn = len(inputs)+1
    while turn <= index:
        lastTime = spoken[lastSpoken]
        newSpoken = 0
        if lastTime[1] == 0:
            newSpoken = 0
        else:
            newSpoken = lastTime[0] - lastTime[1]
        lastTimeNewSpoken = spoken.get(newSpoken, (0,0))
        spoken[newSpoken] = (turn, lastTimeNewSpoken[0])
        lastSpoken = newSpoken
        turn += 1
    return lastSpoken

def algoPart1(inputs):
    return algo(inputs, 2020)

def algoPart2(inputs):
    return algo(inputs, 30000000)

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().split(',')
    inputsNum = [int(str) for str in inputs]

    print(algoPart1(inputsNum))
    print(algoPart2(inputsNum))