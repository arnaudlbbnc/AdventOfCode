import re

inputFile = open('input.txt', 'r')
inputs = inputFile.read().splitlines()

class Passport:
    mandatoryFields = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]

    eyeColors = ["amb","blu","brn","gry","grn","hzl","oth"]

    def __init__(self, lines):
        self.fields = {}
        for str in ' '.join(lines).split(' '):
            keyValue = str.split(':')
            self.fields[keyValue[0]] = keyValue[1]

    def __str__(self):
        return "{}".format(self.fields)

    def containsAllManadatoryField(self):
        fieldsKeys = self.fields.keys()
        for key in Passport.mandatoryFields:
            if key not in fieldsKeys:
                return False
        return True

    def keysHaveValidValue(self):
        for key, value in self.fields.items():
            if key == "byr" and re.fullmatch(r'(19[2-9][0-9]|200[0-2])', value) == None:
                return False
            elif key == "iyr" and re.fullmatch(r'(201[0-9]|2020)', value) == None:
                return False
            elif key == "eyr" and re.fullmatch(r'(202[0-9]|2030)', value) == None:
                return False
            elif key == "hgt":
                search = re.search(r'(\d+)(\w+)', value)
                height = search.group(1)
                unit = search.group(2)
                if unit == "cm" and re.fullmatch(r'1([5-8][0-9]|9[0-3])', height) == None:
                    return False
                elif unit == "in" and re.fullmatch(r'(59|6[0-9]|7[0-6])', height) == None:
                    return False
                elif unit != "cm" and unit != "in":
                    return False
            elif key == "hcl" and re.fullmatch(r'#([a-f0-9]{6})', value) == None:
                return False
            elif key == "ecl" and value not in Passport.eyeColors:
                return False
            elif key == "pid" and re.fullmatch(r'[0-9]{9}', value) == None:
                return False
        return True

passports = []
passportLines = []
for input in inputs:
    if input == '':
        passports.append(Passport(passportLines))
        passportLines = []
    else:
        passportLines.append(input)
passports.append(Passport(passportLines))
def algoPart1():
    count = 0
    for passport in passports:
        count += 1 if passport.containsAllManadatoryField() else 0
    return count

def algoPart2():
    count = 0
    for passport in passports:
        count += 1 if passport.containsAllManadatoryField() and passport.keysHaveValidValue() else 0
    return count


print(algoPart1())
print(algoPart2())