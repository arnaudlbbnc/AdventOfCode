from pathlib import Path


def firstMarker(inputs, size):
    index = 0
    for i in range(0, len(inputs)-size):
        inputsSublist = inputs[i:i+size]
        if len(inputsSublist) == len(set(inputsSublist)):
            index = i+size
            break
    return index


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = list(inputFile.read().splitlines()[0])

    print(firstMarker(inputs, 4))
    print(firstMarker(inputs, 14))
