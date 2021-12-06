//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day8: Day {
    override var number: Int { return 8 }

    override var status: DayStatus { return .done }

    var input: [[Int]]!

    override func loadInput() {
        guard let data = getDataInput(),
            var str = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .newlines) else {
            return
        }
        var input: [[Int]] = []
        for _ in 0..<100 {
            let layer = Array(String(str.prefix(150)))
            input.append(layer.compactMap({Int(String($0))}))
            str.removeFirst(150)
        }
        self.input = input
    }

    override func getResult() -> String {
//            let value = getStepOne(input: input)
            let value = getStepTwo(input: input)
            return "\(value)"
        }

    private func getStepOne(input: [[Int]]) -> Int {
        let minZero = input.min { (left, right) -> Bool in
            let leftZero = left.filter({$0==0}).count
            let rightZero = right.filter({$0==0}).count
            return leftZero < rightZero
        }

        let one = minZero?.filter({$0==1}).count ?? 0
        let two = minZero?.filter({$0==2}).count ?? 0
        return one * two
    }

    private func getStepTwo(input: [[Int]]) -> [Int] {
        guard var layer = input.first else { return [] }

        var input = input
        input.removeFirst(1)

        for pixelIndex in 0..<layer.count {
            var pixel = layer[pixelIndex]

            guard pixel == 2 else { continue }

            var index = 0
            while pixel == 2 {
                pixel = input[index][pixelIndex]
                index += 1
            }
            layer[pixelIndex] = pixel
        }

        return layer
    }
}
