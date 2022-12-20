from pathlib import Path
import math

class Element:
    def __init__(self, value):
        self.value = value
        
def shift(element, list):
    fromIndex = list.index(element)
    newIndex = (fromIndex + element.value) % (len(list)-1)
    list.remove(element)
    list.insert(newIndex, element)
    return list

def mixList(initialList, times=1):
    list = initialList.copy()
    for i in range(0, times):
        for element in initialList:
            list = shift(element, list)
    return list

def part(inputs, decryptionKey = 1, times = 1):
    initialInputsNum = [int(str)*decryptionKey for str in inputs]
    indexOfZero = initialInputsNum.index(0)
    initialElements = [Element(int) for int in initialInputsNum]
    elementZero = initialElements[indexOfZero]
    
    listMixed = mixList(initialElements.copy(), times)
    indexOfElementZero = listMixed.index(elementZero)
    indexes = [num+indexOfElementZero for num in [1000, 2000, 3000]]
    elements = [listMixed[index%len(listMixed)] for index in indexes]
    print(sum([element.value for element in elements]))

if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    
    # PART 1
    part(inputs)
    # PART 2
    part(inputs, 811589153, 10)
    