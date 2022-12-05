from pathlib import Path


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsPair = [str.split(',') for str in inputs]

    sumSubsets = 0
    sumOverlaps = 0
    for inputPair in inputsPair:
        leftRangeStr = inputPair[0].split('-')
        leftRange = set(range(int(leftRangeStr[0]), int(leftRangeStr[1])+1))
        rightRangeStr = inputPair[1].split('-')
        rightRange = set(range(int(rightRangeStr[0]), int(rightRangeStr[1])+1))

        if leftRange.issubset(rightRange) or rightRange.issubset(leftRange):
            sumSubsets += 1
            sumOverlaps += 1
        elif len(leftRange.intersection(rightRange)) > 0:
            sumOverlaps += 1
    print(sumSubsets)
    print(sumOverlaps)
