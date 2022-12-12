from pathlib import Path

if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    commands = inputFile.read().splitlines()

    values = []
    cycle = 0
    register = 1
    crt = ''
    spritePosition = 1

    def updateValues():
        if cycle in [20, 60, 100, 140, 180, 220]:
            values.append(register*cycle)

    def updateCRT():
        global crt
        if spritePosition <= cycle % 40 < spritePosition + 3:
            crt += '#'
        else:
            crt += '.'
        if cycle % 40 == 0:
            crt += '\n'

    for command in commands:
        commandInformations = command.split(' ')
        if commandInformations[0] == 'addx':
            for i in range(2):
                cycle += 1
                updateValues()
                updateCRT()
            register += int(commandInformations[1])
            spritePosition += int(commandInformations[1])
        else:
            cycle += 1
            updateValues()
            updateCRT()

    print(sum(values))
    print(crt)
