inputFile = open('input.txt', 'r')
inputs = inputFile.readlines()

class Line:
    def __init__(self, text):
        self.text = text
        self.treePositions = [i for i, ltr in enumerate(text) if ltr == '#']


def lineStrToLine(line):
    return Line(line)

def nbTrees(horizontalIncrement, verticalIncrement):
    nbTrees = 0
    currentHorizontalPosition = 0
    currentVerticalPosition = 0

    lines = list(map(lineStrToLine, inputs))

    while currentVerticalPosition < len(lines):
        line = lines[currentVerticalPosition]
        nbTrees += 1 if (currentHorizontalPosition % 31) in line.treePositions else 0
        currentHorizontalPosition += horizontalIncrement
        currentVerticalPosition += verticalIncrement
        
    return nbTrees

def algoPart1():
    return nbTrees(3, 1)

def algoPart2():
    return nbTrees(1, 1) * nbTrees(3, 1) * nbTrees(5, 1) * nbTrees(7, 1) * nbTrees(1, 2)

print(algoPart1())
print(algoPart2())