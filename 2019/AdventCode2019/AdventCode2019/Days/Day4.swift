//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day4: Day {
    override var number: Int { return 4 }

    override var status: DayStatus { return .done }

    private var input: ClosedRange<Int>!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let bounds = str.trimmingCharacters(in: .newlines).components(separatedBy: "-").compactMap({Int($0)})
        input = bounds[0]...bounds[1]
    }

    override func getResult() -> String {
        var total = 0
        for i in input {
            let str = "\(i)"
            if Array(str) != str.sorted() {
                continue
            }
            if stringContainsAdjacentElements(str: str) {
                total += 1
            }
        }
        return "\(total)"
    }

    func stringContainsAdjacentElements(str: String) -> Bool {
        let startIndex = str.startIndex
        for i in 0..<str.count-1 {
            if str[str.index(startIndex, offsetBy: i)] == str[str.index(startIndex, offsetBy: i+1)],
                str.filter({$0==str[str.index(startIndex, offsetBy: i)]}).count == 2 {
                return true
            }
        }
        return false
    }
}
