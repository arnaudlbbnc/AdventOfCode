import re
from collections import defaultdict

def parseBags():
    inputFile = open('input.txt', 'r') 
    inputs = inputFile.readlines()

    allBags = {}
    for input in inputs:
        bags = re.findall(r'([a-zA-Z]+ [a-zA-Z]+) bags?', input)
        mainBag = bags[0]
        containedBags = []
        for bag in bags[1:]:
            containedBags.append(bag)
        allBags[mainBag] = containedBags
            
    return allBags

def algoPart1(allBags):
    firstLevelBagsGoldContainer = list(dict(filter(lambda bag: shinyGoldBag in bag[1], allBags.items())).keys())
    firstLevelSet = set(firstLevelBagsGoldContainer)
    secondLevelBagsGoldContainer = list(dict(filter(lambda bag: firstLevelSet & set(bag[1]) , allBags.items())).keys())
    return len(firstLevelBagsGoldContainer + secondLevelBagsGoldContainer)

def algoPart2():
    return 0

shinyGoldBag = "shiny gold"

if __name__ == "__main__":
    allBags = parseBags()

    print(algoPart1(allBags))
    print(algoPart2())