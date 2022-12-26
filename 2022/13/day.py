from pathlib import Path
from functools import cmp_to_key


def compare(left, right):
    if type(left) is int and type(right) is int:
        if left == right:
            return 0
        else:
            if left < right:
                return 1
            else:
                return -1
    elif type(left) is list and type(right) is list:
        index = 0
        while index < len(left) and index < len(right):
            leftPacket = left[index]
            rightPacket = right[index]
            comparison = compare(leftPacket, rightPacket)
            if comparison != 0:
                return comparison
            index += 1
        if len(left) < len(right):
            return 1
        elif len(left) > len(right):
            return -1
        else:
            return 0
    elif type(left) is int:
        left = [left]
        return compare(left, right)
    elif type(right) is int:
        right = [right]
        return compare(left, right)


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().split('\n\n')

    pairs = [input.split('\n') for input in inputs]

    allPackets = []
    index = 1
    sum = 0
    for pair in pairs:
        leftPacket = eval(pair[0])
        allPackets.append(leftPacket)
        rightPacket = eval(pair[1])
        allPackets.append(rightPacket)
        comparison = compare(leftPacket, rightPacket)
        if comparison == 1:
            sum += index
        index += 1
    print(sum)

    allPackets.append([[2]])
    allPackets.append([[6]])

    allPackets.sort(key=cmp_to_key(compare), reverse=True)
    firstDividerIndex = allPackets.index([[2]])
    secondDividerIndex = allPackets.index([[6]])
    print((firstDividerIndex + 1) * (secondDividerIndex + 1))
