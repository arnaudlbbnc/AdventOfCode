from pathlib import Path


def algoPart1():
    return 0


def algoPart2():
    return 0


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsNum = [int(str) for str in inputs]

    print(algoPart1())
    print(algoPart2())
