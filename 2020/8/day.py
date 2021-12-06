def executeInstructions(instructions):
    def calculate(operator, number, value):
        if operator == "+":
            return number + value
        elif operator == "-":
            return number - value
        else:
            return number

    accumulator = 0
    visitedIndexes = []
    index = 0
    while index < len(instructions):
        visitedIndexes.append(index)
        elements = instructions[index].split(' ')
        command = elements[0]
        argument = elements[1]
        operator = argument[0]
        number = int(argument[1:])

        if command == "acc":
            accumulator = calculate(operator, accumulator, number)
        elif command == "jmp":
            newIndex = calculate(operator, index, number)
            if newIndex in visitedIndexes:
                return (False, accumulator)
            else:
                index = newIndex
                continue
        index += 1
    return (True, accumulator)

def correctInstructionsAndExecute(instructions):
    for i in range(len(instructions)):
        instruction = instructions[i]
        command = instruction[:3]
        if command not in ["jmp", "nop"]:
            continue
        if command == "jmp":
            instructions[i] = "nop" + instruction[3:]
        elif command == "nop":
            instructions[i] = "jmp" + instruction[3:]
        result = executeInstructions(instructions)
        if result[0]:
            return result
        instructions[i] = instruction

if __name__ == "__main__":
    inputFile = open('input.txt', 'r') 
    inputs = inputFile.read().splitlines()

    print(executeInstructions(inputs))
    print(correctInstructionsAndExecute(inputs))

