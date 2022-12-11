from pathlib import Path
from operator import attrgetter


class Node(object):
    def __init__(self, parent=None, size=0):
        self.parent = parent
        self.size = size
        self.children = []

    def add_child(self, obj):
        self.children.append(obj)

    def calculateSize(self):
        if self.size == 0:
            childrenSizes = sum([child.calculateSize()
                                for child in self.children])
            self.size = childrenSizes
        return self.size


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()[1:]

    allDirectories = []
    currentNode = Node()
    for input in inputs:
        commandInformations = input.split(' ')
        if commandInformations[0] == '$':
            if commandInformations[1] == 'cd':
                if commandInformations[2] == '..':
                    currentNode = currentNode.parent
                else:
                    newNode = Node(parent=currentNode)
                    currentNode.add_child(newNode)
                    currentNode = newNode
                    allDirectories.append(newNode)
        elif commandInformations[0] != 'dir':
            currentNode.add_child(
                Node(parent=currentNode, size=int(commandInformations[0])))

    while currentNode.parent is not None:
        currentNode = currentNode.parent

    totalSize = currentNode.calculateSize()
    spaceToDelete = 30000000 - (70000000 - totalSize)

    [directory.calculateSize() for directory in allDirectories]

    smallDirectories = list(
        filter(lambda node: node.size < 100000, allDirectories))

    print(sum([smallDirectory.size for smallDirectory in smallDirectories]))

    directoryToDelete = min(list(
        filter(lambda node: node.size > spaceToDelete, allDirectories)), key=attrgetter('size'))
    print(directoryToDelete.size)
