def algoPart1(lanternfishes):
    return countLanternfishesAfterDays(lanternfishes, 18)

def algoPart2(lanternfishes):
    return countLanternfishesAfterDays(lanternfishes, 256)

def countLanternfishesAfterDays(lanternfishes, days):
    array = [0] * 9
    for lanternfish in lanternfishes:
        array[lanternfish] += 1
    
    for i in range(days):
        eights = array[0]
        array[0] = array[1]
        array[1] = array[2]
        array[2] = array[3]
        array[3] = array[4]
        array[4] = array[5]
        array[5] = array[6]
        array[6] = array[7] + eights
        array[7] = array[8]
        array[8] = eights

    return sum(array)



if __name__ == "__main__":
    inputFile = open('input.txt', 'r')
    inputs = inputFile.read().splitlines()
    
    lanternfishes = list(map(int, inputs[0].split(',')))

    print(algoPart1(lanternfishes.copy()))
    print(algoPart2(lanternfishes.copy()))