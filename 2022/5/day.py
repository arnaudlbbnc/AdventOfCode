from pathlib import Path
import copy
import time

MAX_LINES = 100


def printStacks(leftStacks, rightStacks):
    stacks = copy.deepcopy(leftStacks)
    stacks.extend([['']]*5)
    stacks.extend(copy.deepcopy(rightStacks))
    max = MAX_LINES
    representation = ""
    for i in range(max, 0, -1):
        for stack in stacks:
            if i <= len(stack) and stack[i-1] != '':
                representation += '[' + stack[i-1] + '] '
            else:
                representation += '    '
        representation += '\n'
    print(representation)
    time.sleep(0.05)


def extractCommandInformations(command):
    import re
    regex_pattern = '|'.join(map(re.escape, ["move ", "from ", "to "]))
    return [int(info) for info in re.split(regex_pattern, command, 3)[1:]]


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()

    stacks = [[] for i in range(0, 9)]
    for i in range(8, 0, -1):
        stackIndex = i - 1
        for j in range(0, 9):
            crateIndex = j*4+1
            if inputs[stackIndex][crateIndex] != " ":
                stacks[j].append(inputs[stackIndex][crateIndex])

    partOneStacks = copy.deepcopy(stacks)
    partTwoStacks = copy.deepcopy(stacks)
    print("\n"*MAX_LINES)
    for command in inputs[10:]:
        printStacks(partOneStacks, partTwoStacks)
        commandInformations = extractCommandInformations(command)

        for number in range(0, commandInformations[0]):
            partOneStacks[commandInformations[2] -
                          1].append(partOneStacks[commandInformations[1]-1].pop())

        partTwoStacks[commandInformations[2] -
                      1].extend(partTwoStacks[commandInformations[1]-1][-commandInformations[0]:])
        del partTwoStacks[commandInformations[1]-1][-commandInformations[0]:]
        print("\033[F"*MAX_LINES)
    printStacks(partOneStacks, partTwoStacks)

    print(''.join([stack[-1] for stack in partOneStacks]))
    print(''.join([stack[-1] for stack in partTwoStacks]))
