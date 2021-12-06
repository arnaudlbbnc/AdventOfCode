import functools

class Group:
    def __init__(self, answers):
        self.groupAnswers = ''.join(answers)
        self.persons = map(lambda personAnswers: Person(personAnswers), answers)


    def countUniqueAnswers(self):
        uniqueAnswersNb = len(set(self.groupAnswers))
        return uniqueAnswersNb

    def countEquivoqueAnswers(self):
        allAnswersSet = list(map(lambda person: person.answersSet, self.persons))
        return len(allAnswersSet[0].intersection(*allAnswersSet))
        

class Person:
    def __init__(self, answers):
        self.answersStr = answers
        self.answersSet = set([answer for answer in answers])

def parseGroups():
    inputFile = open('input.txt', 'r') 
    inputs = inputFile.read().splitlines()

    groups = []
    groupAnswers = []
    for input in inputs:
        if input == '':
            groups.append(Group(groupAnswers))
            groupAnswers = []
        else:
            groupAnswers.append(input)
    groups.append(Group(groupAnswers))
    return groups

def algoPart1(groups):
    counter = 0
    for group in groups:
        counter += group.countUniqueAnswers()
    return counter

def algoPart2(groups):
    counter = 0
    for group in groups:
        counter += group.countEquivoqueAnswers()
    return counter

if __name__ == "__main__":
    groups = parseGroups()

    print(algoPart1(groups))
    print(algoPart2(groups))