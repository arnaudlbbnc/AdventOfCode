from pathlib import Path
import re

def monkeyForName(name, monkeys):
    return next(monkey for monkey in monkeys if monkey.name == name)

def extractMonkeys(expression):
    monkeysFromExpression = re.split(r' \+ | - | \* | / ', expression)
    return [monkeyForName(monkeysFromExpression[0], monkeys), 
            monkeyForName(monkeysFromExpression[1], monkeys)]

class Monkey:
    def __init__(self, name, expression = None, value = None):
        self.name = name
        self.expression = expression
        self.value = value
        
    def calculate(self, monkeys):
        if self.value == 'x':
            return None
        if self.value != None:
            return self.value
        expressionMonkeys = extractMonkeys(self.expression)
        leftMonkeyValue = expressionMonkeys[0].calculate(monkeys)
        rightMonkeyValue = expressionMonkeys[1].calculate(monkeys)
        if leftMonkeyValue == None or rightMonkeyValue == None:
            return None
        if "+" in self.expression:
            self.value = leftMonkeyValue + rightMonkeyValue
        elif "-" in self.expression:
            self.value = leftMonkeyValue - rightMonkeyValue
        elif "*" in self.expression:
            self.value = leftMonkeyValue * rightMonkeyValue
        elif "/" in self.expression:
            self.value = leftMonkeyValue / rightMonkeyValue
        return self.value
    
    def representation(self):
        if self.value != None:
            return str(self.value)
        expressionMonkeys = extractMonkeys(self.expression)
        leftMonkeyRepresentation = expressionMonkeys[0].representation()
        rightMonkeyRepresentation = expressionMonkeys[1].representation()
        if "+" in self.expression:
            return '(' + leftMonkeyRepresentation + ' + ' + rightMonkeyRepresentation + ')'
        elif "-" in self.expression:
            return '(' + leftMonkeyRepresentation + ' - ' + rightMonkeyRepresentation + ')'
        elif "*" in self.expression:
            return '(' + leftMonkeyRepresentation + ' * ' + rightMonkeyRepresentation + ')'
        elif "/" in self.expression:
            return '(' + leftMonkeyRepresentation + ' / ' + rightMonkeyRepresentation + ')'
        
    
            

if __name__ == "__main__":
    inputFile = open(Path(__file__).absolute().parent / 'input.txt', 'r')
    inputs = inputFile.read().splitlines()
    
    monkeys = []
    for input in inputs:
        monkeyInformations = input.split(': ')
        if monkeyInformations[1].isdigit():
            monkeys.append(Monkey(monkeyInformations[0], value=int(monkeyInformations[1])))
        else:
            monkeys.append(Monkey(monkeyInformations[0], expression=monkeyInformations[1]))
            
    monkeyRoot = monkeyForName('root', monkeys)
    print(monkeyRoot.calculate(monkeys))
    
    for monkey in monkeys:
        if monkey.expression != None:
            monkey.value = None
    human = monkeyForName('humn', monkeys)
    human.value = 'x'
    
    rootExpressionMonkeys = extractMonkeys(monkeyRoot.expression)
    leftValue = rootExpressionMonkeys[0].calculate(monkeys)
    rightValue = rootExpressionMonkeys[1].calculate(monkeys)
    
    newValue = 0
    if leftValue != None:
        newValue = leftValue
    elif rightValue != None:
        newValue = rightValue
        
    rep = ''
    if leftValue != None:
        rep = rootExpressionMonkeys[1].representation()
    elif rightValue != None:
        rep = rootExpressionMonkeys[0].representation()
    rep += ' = ' + str(newValue)
    
    import sympy
    
    x = sympy.symbols('x')
    sympy_eq = sympy.sympify("Eq(" + rep.replace("=", ",") + ")")
    truc = sympy.solve(sympy_eq)
    print(truc)
    
    
    