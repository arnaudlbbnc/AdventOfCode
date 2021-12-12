class Line:
    def __init__(self, patterns, outputs):
        self.patterns = [''.join(sorted(pattern)) for pattern in patterns]
        self.outputs = [''.join(sorted(output)) for output in outputs]

    def getMapping(self):
        mapping = {}
        one = list(filter(lambda pattern: len(pattern) == 2, self.patterns))[0]
        seven = list(filter(lambda pattern: len(pattern) == 3, self.patterns))[0]
        four = list(filter(lambda pattern: len(pattern) == 4, self.patterns))[0]
        eight = list(filter(lambda pattern: len(pattern) == 7, self.patterns))[0]
        mapping[one] = "1"
        mapping[seven] = "7"
        mapping[four] = "4"
        mapping[eight] = "8"
        lengthSix = list(filter(lambda pattern: len(pattern) == 6, self.patterns))
        zero = list(filter(lambda pattern: containsAll(pattern, seven) and not containsAll(pattern, four), lengthSix))[0]
        nine = list(filter(lambda pattern: containsAll(pattern, four), lengthSix))[0]
        lengthSix.remove(zero)
        lengthSix.remove(nine)
        six = lengthSix[0]
        lengthFive = list(filter(lambda pattern: len(pattern) == 5, self.patterns))
        three = list(filter(lambda pattern: containsAll(pattern, one), lengthFive))[0]
        five = list(filter(lambda pattern: containsAll(nine, pattern) and not containsAll(pattern, one), lengthFive))[0]
        lengthFive.remove(three)
        lengthFive.remove(five)
        two = lengthFive[0]
        mapping[zero] = "0"
        mapping[six] = "6"
        mapping[nine] = "9"
        mapping[two] = "2"
        mapping[three] = "3"
        mapping[five] = "5"
        return mapping

    def getOutputsValue(self):
        mapping = self.getMapping()
        values = ""
        for output in self.outputs:
            values += mapping[''.join(sorted(output))]
        return int(values)

def algoPart1(lines):
    outputs = [output for line in lines for output in line.outputs]
    preferredLengths = [2, 4, 3, 7]
    return len(list(filter(lambda output: len(output) in preferredLengths, outputs)))

def algoPart2(lines):
    return sum([line.getOutputsValue() for line in lines])

def containsAll(str, set):
    return 0 not in [c in str for c in set]

if __name__ == "__main__":

    def formatInputLine(input):
        elements = input.split(' | ')
        return Line(elements[0].split(' '), elements[1].split(' '))

    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    inputsLine = [formatInputLine(input) for input in inputs]

    print(algoPart1(inputsLine))
    print(algoPart2(inputsLine))