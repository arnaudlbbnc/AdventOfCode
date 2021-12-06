def algoPart1(inputs):
    increasedDepth = 0
    for i in range(len(inputs)-1):
        increasedDepth += inputs[i+1] > inputs[i]
    return increasedDepth

def algoPart2(inputs):
    increasedDepth = 0
    for i in range(len(inputs)-3):
        increasedDepth += inputs[i+1] + inputs[i+2] + inputs[i+3] > inputs[i] + inputs[i+1] + inputs[i+2]
    return increasedDepth

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsNum = [int(str) for str in inputs]

    print(algoPart1(inputsNum))
    print(algoPart2(inputsNum))