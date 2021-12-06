//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day2: Day {
    override var number: Int { return 2 }

    override var status: DayStatus { return .done }

    var input: [Int]!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let elements = str.components(separatedBy: ",")
        self.input = elements.compactMap({Int($0)})
    }

    override func getResult() -> String {
        for i in 0...99 {
            for j in 0...99 {
                if get(noun: i, verb: j, input: input) == 19690720 {
                    return "\(100 * i + j)"
                }
            }
        }
        return ""
    }

    private func get(noun: Int, verb: Int, input: [Int]) -> Int {
        var input = input
        var index = 0
        input[1] = noun
        input[2] = verb
        while let op = Operator(rawValue: input[index]), op != .abort {
            let leftIndex = input[index+1]
            let rightIndex = input[index+2]
            let replacementIndex = input[index+3]
            let leftValue = input[leftIndex]
            let rightValue = input[rightIndex]
            let value = op.operate(leftValue: leftValue, rightValue: rightValue)
            input[replacementIndex] = value
            index+=4
        }
        return input[0]
    }

    private enum Operator: Int {
        case add = 1
        case multiply = 2
        case abort = 99

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
}
