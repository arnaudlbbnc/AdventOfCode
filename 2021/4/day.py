class Board:
    def __init__(self, lines):
        self.grid = list(map(lambda line: list(map(int, line.split())), lines))
        self.markedNumbers = []

    def gotBingo(self):
        lines = self.grid
        columns = list(map(list, zip(*reversed(self.grid))))
        all = lines + columns
        for x in all:
            if len([number for number in x if number in self.markedNumbers]) == len(x):
                return True
        return False

    def unmarkedNumbers(self):
        allNumbers = [number for line in self.grid for number in line]
        return [number for number in allNumbers if number not in self.markedNumbers]

    def markNumber(self, number):
        self.markedNumbers.append(number)

    def testNumbers(self, numbers):
        for number in numbers:
            self.markNumber(number)
            if self.gotBingo():
                break

    def __lt__(self, other):
         return len(self.markedNumbers) < len(other.markedNumbers)

class Bingo:
    def __init__(self, numbers, boards):
        self.numbers = numbers
        self.boards = boards

    def launch(self):
        localBoards = self.boards.copy()
        for number in self.numbers:
            for board in localBoards:
                board.markNumber(number)
                if board.gotBingo():
                    return sum(board.unmarkedNumbers()) * board.markedNumbers[-1]
        return 0

    def launchEasyMode(self):
        localBoards = self.boards.copy()
        for board in localBoards:
            board.testNumbers(self.numbers)
        localBoards.sort()
        return sum(localBoards[-1].unmarkedNumbers()) * localBoards[-1].markedNumbers[-1]
                

def algoPart1(numbers, boards):
    bingo = Bingo(numbers, boards)
    return bingo.launch()

def algoPart2(numbers, boards):
    bingo = Bingo(numbers, boards)
    return bingo.launchEasyMode()

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()

    numbers = [int(number) for number in inputs[0].split(",")]

    boards = []
    for i in range(2, len(inputs), 6):
        boards.append(Board(inputs[i:i+5]))

    print(algoPart1(numbers, boards))
    print(algoPart2(numbers, boards))
