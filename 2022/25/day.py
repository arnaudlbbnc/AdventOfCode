from pathlib import Path


def snafuToDecimal(snafu):
    sum = 0
    characters = list(reversed(snafu))
    for index, character in enumerate(characters):
        match character:
            case '-':
                characterValue = -1
            case '=':
                characterValue = -2
            case _:
                characterValue = int(character)
        sum += characterValue * pow(5, index)
    return sum


def decimalToSnafu(number):
    snafu = ''
    while number:
        number, remainder = divmod(number, 5)
        match remainder:
            case 0 | 1 | 2:
                snafu = str(remainder) + snafu
            case 3:
                number += 1
                snafu = '=' + snafu
            case 4:
                number += 1
                snafu = '-' + snafu
    return snafu


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'inputTest2.txt', 'r')
    inputs = inputFile.read().splitlines()

    decimalSum = sum([snafuToDecimal(snafu) for snafu in inputs])
    print(decimalSum)
    snafuSum = decimalToSnafu(decimalSum)
    print(snafuSum)
