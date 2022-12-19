from pathlib import Path
from collections import deque
from string import ascii_lowercase


def adjacent(x: int, y: int) -> list[tuple[int, int]]:
    return [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]


def find_shortest_path(grid: dict[tuple[int, int], int], start: tuple[int, int], goal: tuple[int, int]) -> int:
    seen = {start}

    d = deque([(0, start)])
    while d:
        steps, current = d.popleft()

        for adj in adjacent(*current):
            if adj in grid and adj not in seen and grid[adj] <= (grid[current] + 1):
                seen.add(adj)

                if adj == goal:
                    return steps + 1

                d.append((steps + 1, adj))

    return -1


if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')

    grid = {}
    allA = []
    for y, line in enumerate(inputFile.readlines()):
        for x, cell in enumerate(line.strip()):
            if cell == 'S':
                start = (x, y)
                grid[(x, y)] = 0
            elif cell == 'E':
                goal = (x, y)
                grid[(x, y)] = 25
            else:
                if cell == 'a':
                    allA.append((x, y))
                grid[(x, y)] = ascii_lowercase.index(cell)

    steps = find_shortest_path(grid, start, goal)
    aSteps = filter(lambda a: a != -1, [find_shortest_path(grid, a, goal) for a in allA])
    print(steps)
    print(min(aSteps))
