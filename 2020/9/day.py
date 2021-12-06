def algoPart1(inputs):
    def additionsResults(inputs):
        results = []
        for i in range(len(inputs)-25):
            for j in range(0,25):
                results.append(inputs[i]+inputs[i+j])
        return results

    results = additionsResults(inputs)
    index = 25
    while index < len(inputs):
        resultIndex = index-25
        if inputs[index] not in results[resultIndex*25:resultIndex*25+625]:
            return inputs[index]
        index += 1
    return 0

def algoPart2(inputs, number):
    for index in range(len(inputs)):
        result = inputs[index]
        minNb = inputs[index]
        maxNb = inputs[index]
        for j in inputs[index+1:]:
            minNb = min(minNb, j)
            maxNb = max(maxNb, j)
            result += j
            if result == number:
                return minNb + maxNb
            elif result > number:
                break
    return 0

if __name__ == "__main__":
    inputFile = open('input.txt', 'r') 
    inputs = inputFile.read().splitlines()
    inputsNum = [int(str) for str in inputs]

    number = algoPart1(inputsNum)
    print(number)
    print(algoPart2(inputsNum, number))