from pathlib import Path


def value(character):
    code = ord(character)
    if 65 <= code <= 90:
        return code - 38
    if 97 <= code <= 122:
        return code - 96


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()

    sum = 0
    for input in inputs:
        leftHalf = set(input[:len(input)//2])
        rightHalf = set(input[len(input)//2:])
        sum += value(list(leftHalf.intersection(rightHalf))[0])
    print(sum)

    sum = 0
    for i in range(0, len(inputs), 3):
        firstElf = set(inputs[i])
        secondElf = set(inputs[i+1])
        thirdElf = set(inputs[i+2])
        sum += value(list(thirdElf.intersection(firstElf.intersection(secondElf)))
                     [0])
    print(sum)
