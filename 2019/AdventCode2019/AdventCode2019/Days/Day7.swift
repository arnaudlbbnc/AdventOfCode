//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day7: Day {
    override var number: Int { return 7 }

    override var status: DayStatus { return .notDone }

    var input: [Int]!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let elements = str.trimmingCharacters(in: .newlines).components(separatedBy: ",")
        self.input = elements.compactMap({Int($0)})
    }

    override func getResult() -> String {
        let value = getStepOne(input: input)
//        let value = getStepTwo(input: input)
        return "\(value)"
    }

    private func getStepOne(input: [Int]) -> Int {
        let settings = [0,1,2,3,4]
        var allSettings: Set<[Int]> = Set()
        for _ in 0..<1000 {
            allSettings.insert(settings.shuffled())
        }
        var outputs: [Int] = []
        for setting in allSettings {
            var output = 0
            for i in 0..<5 {
                output = getOutput(for: output, setting: setting[i], inputs: input)
            }
            outputs.append(output)
        }
        return outputs.max() ?? 0
    }

    private func getStepTwo(input: [Int]) -> Int {
        let settings = [5,6,7,8,9]
        var allSettings: Set<[Int]> = Set()
        for _ in 0..<1000 {
            allSettings.insert(settings.shuffled())
        }
        var outputs: [Int] = []
        for setting in allSettings {
            var indexes: [Int] = [0,0,0,0,0]
            var output = 0
            var i = 0
            var indexAndOutput: (Int, Int) = (0, 0)
            while indexAndOutput.0 != -1 {
                indexAndOutput = getOutputStepTwo(from: indexes[i%5], for: indexAndOutput.1, setting: setting[i%5], inputs: input)
                indexes[i%5] = indexAndOutput.0
                if (i+1) % 5 == 0 {
                    output = indexAndOutput.1
                }
                i += 1
            }
            outputs.append(output)
        }
        return outputs.max() ?? 0
    }

    private func getOutput(for input: Int, setting: Int, inputs: [Int]) -> Int {
        var numberOfInput = 0
        var inputs = inputs
        var index = 0
        var value = 0
        var instruction = Instruction.create(from: inputs[index])
        while instruction.op != .abort {
            let op = instruction.op
            if op == .add || op == .multiply {
                let leftValue: Int
                if instruction.firstParameterMode == .immediate {
                    leftValue = inputs[index+1]
                } else {
                    let leftIndex = inputs[index+1]
                    leftValue = inputs[leftIndex]
                }
                let rightValue: Int
                if instruction.secondParameterMode == .immediate {
                    rightValue = inputs[index+2]
                } else {
                    let rightIndex = inputs[index+2]
                    rightValue = inputs[rightIndex]
                }
                let replacementIndex = inputs[index+3]
                let value = instruction.op.operate(leftValue: leftValue, rightValue: rightValue)
                inputs[replacementIndex] = value
                index+=4
            } else if op == .input {
                numberOfInput += 1
                let storeInput = inputs[index+1]
                if numberOfInput == 1 {
                    inputs[storeInput] = setting
                } else {
                    inputs[storeInput] = input
                }

                index+=2
            } else if op == .output {
                value = inputs[inputs[index+1]]
                index+=2
            } else if op == .jumpIfTrue {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue != 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .jumpIfFalse {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue == 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .lessThan {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue < secondValue {
                    inputs[inputs[index+3]] = 1
                } else {
                    inputs[inputs[index+3]] = 0
                }
                index += 4
            } else if op == .equals {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue == secondValue {
                    inputs[inputs[index+3]] = 1
                } else {
                    inputs[inputs[index+3]] = 0
                }
                index += 4
            }
            instruction = Instruction.create(from: inputs[index])
        }
        return value
    }

    private func getOutputStepTwo(from index: Int, for input: Int, setting: Int, inputs: [Int]) -> (Int, Int) {
        var numberOfInput = 0
        var inputs = inputs
        var index = index
        var value = 0
        var instruction = Instruction.create(from: inputs[index])
        while instruction.op != .abort {
            let op = instruction.op
            if op == .add || op == .multiply {
                let leftValue: Int
                if instruction.firstParameterMode == .immediate {
                    leftValue = inputs[index+1]
                } else {
                    let leftIndex = inputs[index+1]
                    leftValue = inputs[leftIndex]
                }
                let rightValue: Int
                if instruction.secondParameterMode == .immediate {
                    rightValue = inputs[index+2]
                } else {
                    let rightIndex = inputs[index+2]
                    rightValue = inputs[rightIndex]
                }
                let replacementIndex = inputs[index+3]
                let value = instruction.op.operate(leftValue: leftValue, rightValue: rightValue)
                inputs[replacementIndex] = value
                index+=4
            } else if op == .input {
                numberOfInput += 1
                let storeInput = inputs[index+1]
                if numberOfInput == 1 {
                    inputs[storeInput] = setting
                } else {
                    inputs[storeInput] = input
                }

                index+=2
            } else if op == .output {
                value = inputs[inputs[index+1]]
                index+=2
                return (index, value)
            } else if op == .jumpIfTrue {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue != 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .jumpIfFalse {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue == 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .lessThan {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue < secondValue {
                    inputs[inputs[index+3]] = 1
                } else {
                    inputs[inputs[index+3]] = 0
                }
                index += 4
            } else if op == .equals {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = inputs[index+1]
                } else {
                    let firstIndex = inputs[index+1]
                    firstValue = inputs[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = inputs[index+2]
                } else {
                    let secondIndex = inputs[index+2]
                    secondValue = inputs[secondIndex]
                }
                if firstValue == secondValue {
                    inputs[inputs[index+3]] = 1
                } else {
                    inputs[inputs[index+3]] = 0
                }
                index += 4
            }
            instruction = Instruction.create(from: inputs[index])
        }
        return (-1, value)
    }

    private enum Operator: String {
        case add
        case multiply
        case input
        case output
        case jumpIfTrue
        case jumpIfFalse
        case lessThan
        case equals
        case abort

        init(from value: String) {
            switch value {
            case "01", "1":
                self = .add
            case "02", "2":
                self = .multiply
            case "03", "3":
                self = .input
            case "04", "4":
                self = .output
            case "05", "5":
                self = .jumpIfTrue
            case "06", "6":
                self = .jumpIfFalse
            case "07", "7":
                self = .lessThan
            case "08", "8":
                self = .equals
            default:
                self = .abort
            }
        }

        func operate(leftValue: Int, rightValue: Int) -> Int {
            switch self {
            case .add:
                return leftValue + rightValue
            case .multiply:
                return leftValue * rightValue
            default:
                return -1
            }
        }
    }

    private enum Mode: Int {
        case position = 0
        case immediate = 1
    }

    private class Instruction {
        var firstParameterMode: Mode = .position
        var secondParameterMode: Mode = .position
        var thirdParameterMode: Mode = .position
        var op: Operator!

        private init() {}

        static func create(from value: Int) -> Instruction {
            let instruction = Instruction()

            var valueStr = "\(value)"

            guard valueStr.count > 1 else {
                let opCharacters = String(valueStr.suffix(1))
                instruction.op = Operator(from: opCharacters)
                return instruction
            }

            let opCharacters = String(valueStr.suffix(2))
            instruction.op = Operator(from: opCharacters)
            valueStr.removeLast(2)

            guard instruction.op != .abort else {
                return instruction
            }

            if !valueStr.isEmpty,
                let firstParameter = Int(String(valueStr.suffix(1))) {
                instruction.firstParameterMode = Mode(rawValue: firstParameter) ?? .position
                valueStr.removeLast(1)
            }

            if !valueStr.isEmpty,
                let secondParameter = Int(String(valueStr.suffix(1))) {
                instruction.secondParameterMode = Mode(rawValue: secondParameter) ?? .position
                valueStr.removeLast(1)
            }

            if !valueStr.isEmpty,
                let thirdParameter = Int(String(valueStr.suffix(1))) {
                instruction.thirdParameterMode = Mode(rawValue: thirdParameter) ?? .position
            }

            return instruction
        }
    }
}
