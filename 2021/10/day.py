pairs = { '(': ')', '[': ']', '{': '}', '<': '>'}
openChunkPoints = { ')': 3, ']': 57, '}': 1197, '>': 25137}
closeChunkPoints = { ')': 1, ']': 2, '}': 3, '>': 4}

def algoPart1(lines):
    totalSyntaxErrorScore = 0
    for line in lines:
        openedChunks = []
        for i in range(len(line)):
            char = line[i]
            if char in pairs.keys():
                openedChunks.append(char)
            elif char == pairs[openedChunks[-1]]:
                del openedChunks[-1]
            else:
                totalSyntaxErrorScore += openChunkPoints[char]
                break
    return totalSyntaxErrorScore

def algoPart2(lines):
    scores = []
    for line in lines:
        openedChunks = []
        for i in range(len(line)):
            char = line[i]
            if char in pairs.keys():
                openedChunks.append(char)
            elif char == pairs[openedChunks[-1]]:
                del openedChunks[-1]
            else:
                openedChunks.clear()
                break
        if len(openedChunks) > 0:
            lineScore = 0
            openedChunks.reverse()
            closeChunks = [pairs[chunk] for chunk in openedChunks]
            for chunk in closeChunks:
                lineScore *= 5
                lineScore += closeChunkPoints[chunk]
            scores.append(lineScore)
    scores.sort()
    return scores[int((len(scores) / 2) - .5)]

if __name__ == "__main__":
    inputFile = open('/Users/arnaudlebourblanc/Documents/workspace/Arnaud/AdventOfCode/2021/10/input.txt', 'r')
    inputs = inputFile.read().splitlines()

    print(algoPart1(inputs))
    print(algoPart2(inputs))