from pathlib import Path
from functools import reduce
import math
import copy


class Monkey:
    def __init__(self, items, operation, throwNumber, throwIndexTrue, throwIndexFalse):
        self.items = items
        self.operation = operation
        self.throwNumber = throwNumber
        self.throwIndexTrue = throwIndexTrue
        self.throwIndexFalse = throwIndexFalse
        self.inspectedItems = 0

    def throw(self):
        return self.items.pop(0)

    def gotItemThrownAt(self, item):
        self.items.append(item)

    def operate(self, item):
        operationItems = self.operation.split(' ')
        if operationItems[0] == 'old':
            operationItems[0] = item
        if operationItems[2] == 'old':
            operationItems[2] = item
        if operationItems[1] == '*':
            return (int(operationItems[0]) * int(operationItems[2]))
        else:
            return (int(operationItems[0]) + int(operationItems[2]))

    def do(self, func):
        if len(self.items) == 0:
            return None
        self.inspectedItems += 1
        item = self.throw()
        worryLevel = math.floor(func(self.operate(item)))
        if worryLevel % self.throwNumber == 0:
            return (self.throwIndexTrue, worryLevel)
        else:
            return (self.throwIndexFalse, worryLevel)


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    monkeysInformations = [monkey.splitlines()
                           for monkey in inputFile.read().split('\n\n')]

    monkeys = []
    for monkeyInformations in monkeysInformations:
        items = [int(item) for item in monkeyInformations[1].split(': ')[1].split(', ')]
        operation = monkeyInformations[2].split(' = ')[1]
        throwNumber = int(monkeyInformations[3].removeprefix('  Test: divisible by '))
        throwIndexTrue = int(monkeyInformations[4].removeprefix('    If true: throw to monkey '))
        throwIndexFalse = int(monkeyInformations[5].removeprefix('    If false: throw to monkey '))
        monkeys.append(Monkey(items, operation, throwNumber, throwIndexTrue, throwIndexFalse))

    numberOfRounds = 20
    part1Monkeys = copy.deepcopy(monkeys)
    def func(x): return x / 3
    for i in range(numberOfRounds):
        for monkey in part1Monkeys:
            for j in range(len(monkey.items)):
                infos = monkey.do(func)
                if infos != None:
                    part1Monkeys[infos[0]].gotItemThrownAt(infos[1])
    inspectedItems = [monkey.inspectedItems for monkey in part1Monkeys]
    inspectedItems.sort()
    print(inspectedItems[-1]*inspectedItems[-2])

    numberOfRounds = 10000
    part2Monkeys = copy.deepcopy(monkeys)
    foo = reduce(lambda a, b: a*b, [monkey.throwNumber for monkey in part2Monkeys])
    def func(x): return x % foo
    for i in range(numberOfRounds):
        for monkey in part2Monkeys:
            for j in range(len(monkey.items)):
                infos = monkey.do(func)
                if infos != None:
                    part2Monkeys[infos[0]].gotItemThrownAt(infos[1])
    inspectedItems = [monkey.inspectedItems for monkey in part2Monkeys]
    inspectedItems.sort()
    print(inspectedItems[-1]*inspectedItems[-2])
