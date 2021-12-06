inputFile = open('input.txt', 'r') 
inputs = inputFile.readlines()
inputsNum = [int(str) for str in inputs]

def algoPart1():
    inputsNum2 = inputsNum.copy()
    for num in inputsNum:
        for num2 in inputsNum2:
            if num + num2 == 2020:
                return num * num2
        inputsNum2.pop(0)

def algoPart2():
    inputsNum2 = inputsNum.copy()
    inputsNum3 = inputsNum.copy()
    for num in inputsNum:
        for num2 in inputsNum2:
            for num3 in inputsNum3:
                if num + num2 + num3 == 2020:
                    return num * num2 * num3

print(algoPart1())
print(algoPart2())