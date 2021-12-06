//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day5: Day {
    override var number: Int { return 5 }

    override var status: DayStatus { return .done }

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
//        let value = getStepOne(input: input)
        let value = getStepTwo(input: input)
        return "\(value)"
    }

    private func getStepOne(input: [Int]) -> Int {
        var input = input
        var index = 0
        var value = 0
        var instruction = Instruction.create(from: input[index])
        while instruction.op != .abort {
            if instruction.op == .add || instruction.op == .multiply {
                let leftValue: Int
                if instruction.firstParameterMode == .immediate {
                    leftValue = input[index+1]
                } else {
                    let leftIndex = input[index+1]
                    leftValue = input[leftIndex]
                }
                let rightValue: Int
                if instruction.secondParameterMode == .immediate {
                    rightValue = input[index+2]
                } else {
                    let rightIndex = input[index+2]
                    rightValue = input[rightIndex]
                }
                let replacementIndex = input[index+3]
                let value = instruction.op.operate(leftValue: leftValue, rightValue: rightValue)
                input[replacementIndex] = value
                index+=4
            } else if instruction.op == .input {
                let storeInput = input[index+1]
                input[storeInput] = 1
                index+=2
            } else if instruction.op == .output {
                value = input[input[index+1]]
                index+=2
            }
            instruction = Instruction.create(from: input[index])
        }
        return value
    }

    private func getStepTwo(input: [Int]) -> Int {
        var input = input
        var index = 0
        var value = 0
        var instruction = Instruction.create(from: input[index])
        while instruction.op != .abort {
            let op = instruction.op
            if op == .add || op == .multiply {
                let leftValue: Int
                if instruction.firstParameterMode == .immediate {
                    leftValue = input[index+1]
                } else {
                    let leftIndex = input[index+1]
                    leftValue = input[leftIndex]
                }
                let rightValue: Int
                if instruction.secondParameterMode == .immediate {
                    rightValue = input[index+2]
                } else {
                    let rightIndex = input[index+2]
                    rightValue = input[rightIndex]
                }
                let replacementIndex = input[index+3]
                let value = instruction.op.operate(leftValue: leftValue, rightValue: rightValue)
                input[replacementIndex] = value
                index+=4
            } else if op == .input {
                let storeInput = input[index+1]
                input[storeInput] = 5
                index+=2
            } else if op == .output {
                value = input[input[index+1]]
                index+=2
            } else if op == .jumpIfTrue {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = input[index+1]
                } else {
                    let firstIndex = input[index+1]
                    firstValue = input[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = input[index+2]
                } else {
                    let secondIndex = input[index+2]
                    secondValue = input[secondIndex]
                }
                if firstValue != 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .jumpIfFalse {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = input[index+1]
                } else {
                    let firstIndex = input[index+1]
                    firstValue = input[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = input[index+2]
                } else {
                    let secondIndex = input[index+2]
                    secondValue = input[secondIndex]
                }
                if firstValue == 0 {
                    index = secondValue
                } else {
                    index += 3
                }
            } else if op == .lessThan {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = input[index+1]
                } else {
                    let firstIndex = input[index+1]
                    firstValue = input[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = input[index+2]
                } else {
                    let secondIndex = input[index+2]
                    secondValue = input[secondIndex]
                }
                if firstValue < secondValue {
                    input[input[index+3]] = 1
                } else {
                    input[input[index+3]] = 0
                }
                index += 4
            } else if op == .equals {
                let firstValue: Int
                if instruction.firstParameterMode == .immediate {
                    firstValue = input[index+1]
                } else {
                    let firstIndex = input[index+1]
                    firstValue = input[firstIndex]
                }
                let secondValue: Int
                if instruction.secondParameterMode == .immediate {
                    secondValue = input[index+2]
                } else {
                    let secondIndex = input[index+2]
                    secondValue = input[secondIndex]
                }
                if firstValue == secondValue {
                    input[input[index+3]] = 1
                } else {
                    input[input[index+3]] = 0
                }
                index += 4
            }
            instruction = Instruction.create(from: input[index])
        }
        return value
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
