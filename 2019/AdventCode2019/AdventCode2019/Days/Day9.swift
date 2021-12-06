//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day9: Day {
    override var number: Int { return 9 }

    override var status: DayStatus { return .done }

    var input: [Int]!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
                return
        }
        let elements = str.trimmingCharacters(in: .newlines).components(separatedBy: ",")
        self.input = elements.compactMap({Int($0)})
        self.input.append(contentsOf: Array(repeating: 0, count: 1000))
    }

    override func getResult() -> String {
        let value = getStepOne(input: input)
        return "\(value)"
    }

    private func getValue(from input: [Int], address: Int, relative: Int, mode: Mode) -> Int {
        let value: Int
        if mode == .immediate {
            value = input[address]
        } else if mode == .position {
            let index = input[address]
            value = input[index]
        } else {
            let index = input[address] + relative
            value = input[index]
        }
        return value
    }

    private func getIndexToWrite(from input: [Int], address: Int, relative: Int, mode: Mode) -> Int {
        let index: Int
        if mode == .immediate {
            index = input[address]
        } else if mode == .position {
            index = input[address]
        } else {
            index = input[address] + relative
        }
        return index
    }

    private func getStepOne(input: [Int]) -> Int {
        var input = input
        var index = 0
        var relative = 0
        var instruction = Instruction.create(from: input[index])
        while instruction.op != .abort {
            let op = instruction.op
            if op == .add || op == .multiply { // 1 && 2
                let leftValue: Int = getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                let rightValue: Int = getValue(from: input, address: index+2, relative: relative, mode: instruction.secondParameterMode)
                let replacementIndex: Int = getIndexToWrite(from: input, address: index+3, relative: relative, mode: instruction.thirdParameterMode)
                let value = instruction.op.operate(leftValue: leftValue, rightValue: rightValue)
                input[replacementIndex] = value
                index+=4
            } else if op == .input { // 3
                let storeInput = getIndexToWrite(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                input[storeInput] = 2
                index+=2
            } else if op == .output { // 4
                return getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
            } else if op == .jumpIfTrue { // 5
                let leftValue: Int = getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                let rightValue: Int = getValue(from: input, address: index+2, relative: relative, mode: instruction.secondParameterMode)
                if leftValue != 0 {
                    index = rightValue
                } else {
                    index += 3
                }
            } else if op == .jumpIfFalse { // 6
                let leftValue: Int = getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                let rightValue: Int = getValue(from: input, address: index+2, relative: relative, mode: instruction.secondParameterMode)
                if leftValue == 0 {
                    index = rightValue
                } else {
                    index += 3
                }
            } else if op == .lessThan { // 7
                let leftValue: Int = getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                let rightValue: Int = getValue(from: input, address: index+2, relative: relative, mode: instruction.secondParameterMode)
                let replacementIndex: Int = getIndexToWrite(from: input, address: index+3, relative: relative, mode: instruction.thirdParameterMode)
                if leftValue < rightValue {
                    input[replacementIndex] = 1
                } else {
                    input[replacementIndex] = 0
                }
                index += 4
            } else if op == .equals { // 8
                let leftValue: Int = getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                let rightValue: Int = getValue(from: input, address: index+2, relative: relative, mode: instruction.secondParameterMode)
                let replacementIndex: Int = getIndexToWrite(from: input, address: index+3, relative: relative, mode: instruction.thirdParameterMode)
                if leftValue == rightValue {
                    input[replacementIndex] = 1
                } else {
                    input[replacementIndex] = 0
                }
                index += 4
            } else if op == .relative { // 9
                relative += getValue(from: input, address: index+1, relative: relative, mode: instruction.firstParameterMode)
                index += 2
            }
            instruction = Instruction.create(from: input[index])
        }
        return 0
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
        case relative
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
            case "09", "9":
                self = .relative
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
        case relative = 2
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
