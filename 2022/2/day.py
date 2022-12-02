from pathlib import Path


def algoPart1(inputs):
    solutions = [[3, 6, 0], [0, 3, 6], [6, 0, 3]]
    score = 0
    for input in inputs:
        opponentMove = ord(input[0]) - 64
        myMove = ord(input[1]) - 87
        score += solutions[opponentMove-1][myMove-1] + myMove
    return score


def algoPart2(inputs):
    solutions = [[3, 1, 2], [1, 2, 3], [2, 3, 1]]
    orderPoints = [0, 3, 6]
    score = 0
    for input in inputs:
        opponentMove = ord(input[0]) - 64
        order = ord(input[1]) - 87
        score += solutions[opponentMove-1][order-1] + orderPoints[order-1]
    return score


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsFormated = [str.split(' ') for str in inputs]

    print(algoPart1(inputsFormated))
    print(algoPart2(inputsFormated))
