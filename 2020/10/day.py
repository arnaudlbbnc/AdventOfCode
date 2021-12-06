def algoPart1(inputs):
    counterDict = {1:0, 2:0, 3:0}
    index = 0
    while index < len(inputs)-1:
        difference = inputs[index+1] - inputs[index]
        counterDict[difference] += 1
        index += 1
    return counterDict

def algoPart2(inputs):
    values = {}
    index = len(inputs)-1
    values[inputs[index]] = 1
    while index >= 0:
        jolt = inputs[index]
        joltValue = values.get(jolt, 1)
        values[jolt-1] = values.get(jolt-1, 0) + joltValue
        values[jolt-2] = values.get(jolt-2, 0) + joltValue
        values[jolt-3] = values.get(jolt-3, 0) + joltValue
        index -= 1
    values = {i:values[i] for i in values if i in inputs}
    return values[0]

if __name__ == "__main__":
    inputFile = open('input.txt', 'r') 
    inputs = inputFile.read().splitlines()
    inputsNum = [int(str) for str in inputs]
    inputsNum.sort()
    inputsNum.insert(0, 0)
    inputsNum.append(inputsNum[-1]+3)

    print(algoPart1(inputsNum))
    print(algoPart2(inputsNum))