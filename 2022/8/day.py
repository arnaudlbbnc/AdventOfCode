from pathlib import Path


def calculateSideScenicScore(treeValue, trees):
    score = 0
    for tree in trees:
        score += 1
        if tree >= treeValue:
            break
    if score == 0:
        score = len(trees)
    return score


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    trees = [[int(tree) for tree in list(line)] for line in inputs]

    lines = trees
    columns = list(zip(*trees))

    sumTreesVisible = len(lines)*2 + len(columns)*2 - 4

    maxScenicScore = 0
    for i in range(1, len(lines)-1):
        for j in range(1, len(columns)-1):
            tree = lines[i][j]
            leftTrees = list(reversed(lines[i][:j]))
            rightTrees = lines[i][j+1:]
            upTrees = list(reversed(columns[j][:i]))
            downTrees = columns[j][i+1:]
            if tree > max(leftTrees) or tree > max(rightTrees) or tree > max(upTrees) or tree > max(downTrees):
                sumTreesVisible += 1

            scenicScore = calculateSideScenicScore(tree, leftTrees) * calculateSideScenicScore(
                tree, rightTrees) * calculateSideScenicScore(tree, upTrees) * calculateSideScenicScore(tree, downTrees)
            maxScenicScore = max(scenicScore, maxScenicScore)

    print(sumTreesVisible)
    print(maxScenicScore)
