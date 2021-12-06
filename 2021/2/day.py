def algoPart1(inputs):
    horizontal = 0
    depth = 0
    for input in inputs:
        command = input.split()
        movement = command[0]
        amount = int(command[1])
        if movement == "forward":
            horizontal += amount
        elif movement == "down":
            depth += amount
        elif movement == "up":
            depth -= amount
    return horizontal * depth

def algoPart2(inputs):
    horizontal = 0
    depth = 0
    aim = 0
    for input in inputs:
        command = input.split()
        movement = command[0]
        amount = int(command[1])
        if movement == "forward":
            horizontal += amount
            depth += amount*aim
        elif movement == "down":
            aim += amount
        elif movement == "up":
            aim -= amount
    return horizontal * depth

if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()

    print(algoPart1(inputs))
    print(algoPart2(inputs))