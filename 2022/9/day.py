from pathlib import Path


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    commands = [command.split(' ')
                for command in inputFile.read().splitlines()]

    headPosition = [0, 0]
    tailPosition = [0, 0]
    positionsVisited = set([tuple([0, 0])])
    for command in commands:
        direction = command[0]
        steps = int(command[1])

        for i in range(steps):
            if direction == "R":
                headPosition[0] += 1
            elif direction == "L":
                headPosition[0] -= 1
            elif direction == "U":
                headPosition[1] += 1
            elif direction == "D":
                headPosition[1] -= 1

            if tailPosition[0] in [headPosition[0], headPosition[0]+1, headPosition[0]-1] and tailPosition[1] in [headPosition[1], headPosition[1]+1, headPosition[1]-1]:
                continue

            if headPosition[1] == tailPosition[1]:
                tailPosition[0] += 1 if direction == "R" else -1
            elif headPosition[0] == tailPosition[0]:
                tailPosition[1] += 1 if direction == "U" else -1
            elif headPosition[0] > tailPosition[0]:
                tailPosition[0] += 1
                tailPosition[1] += 1 if headPosition[1] > tailPosition[1] else -1
            elif headPosition[0] < tailPosition[0]:
                tailPosition[0] -= 1
                tailPosition[1] += 1 if headPosition[1] > tailPosition[1] else -1

            positionsVisited.add(tuple(tailPosition))

    print(len(list(positionsVisited)))

    headPosition = [0, 0]
    tailPosition = [[0, 0], [0, 0], [0, 0], [0, 0],
                    [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
    positionsVisited = set([tuple([0, 0])])
    for command in commands:
        direction = command[0]
        steps = int(command[1])

        for i in range(steps):
            if direction == "R":
                headPosition[0] += 1
            elif direction == "L":
                headPosition[0] -= 1
            elif direction == "U":
                headPosition[1] += 1
            elif direction == "D":
                headPosition[1] -= 1

            localHeadPosition = headPosition.copy()
            for index, tail in enumerate(tailPosition):
                if tailPosition[index][0] in [localHeadPosition[0], localHeadPosition[0]+1, localHeadPosition[0]-1] and tailPosition[index][1] in [localHeadPosition[1], localHeadPosition[1]+1, localHeadPosition[1]-1]:
                    localHeadPosition = tailPosition[index]
                    continue

                if localHeadPosition[1] == tailPosition[index][1]:
                    tailPosition[index][0] += 1 if localHeadPosition[0] > tailPosition[index][0] else -1
                elif localHeadPosition[0] == tailPosition[index][0]:
                    tailPosition[index][1] += 1 if localHeadPosition[1] > tailPosition[index][1] else -1
                elif localHeadPosition[0] > tailPosition[index][0]:
                    tailPosition[index][0] += 1
                    tailPosition[index][1] += 1 if localHeadPosition[1] > tailPosition[index][1] else -1
                elif localHeadPosition[0] < tailPosition[index][0]:
                    tailPosition[index][0] -= 1
                    tailPosition[index][1] += 1 if localHeadPosition[1] > tailPosition[index][1] else -1

                localHeadPosition = tailPosition[index]
            positionsVisited.add(tuple(tailPosition[-1]))

    print(len(list(positionsVisited)))
