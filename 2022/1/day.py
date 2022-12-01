from pathlib import Path


def algoPart1(totalCaloriesPerElf):
    return max(totalCaloriesPerElf)


def algoPart2(totalCaloriesPerElf):
    totalCaloriesPerElf.sort(reverse=True)
    return sum(totalCaloriesPerElf[:3])


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    caloriesPerElf = []
    elf = []
    for input in inputs:
        if input != '':
            elf.append(int(input))
        else:
            caloriesPerElf.append(elf)
            elf = []
    totalCaloriesPerElf = [sum(sublist) for sublist in caloriesPerElf]
    print(algoPart1(totalCaloriesPerElf))
    print(algoPart2(totalCaloriesPerElf))
