//
//  Day1.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 02/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day1: Day {
    override var number: Int { return 1 }

    override var status: DayStatus { return .done }

    var input: [Int]!
    
    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let elements = str.components(separatedBy: .newlines)
        self.input = elements.compactMap({Int($0)})
    }

    override func getResult() -> String {
        let total = input.reduce(0) { (total, module) -> Int in
            var masses = [module]
            while let fuelMasse = masses.last, fuelMasse > 6 {
                let newFuelMasse = calculateFuel(from: fuelMasse)
                masses.append(newFuelMasse)
            }
            masses.removeFirst()
            return total + masses.reduce(0, {$0+$1})
        }
        return "\(total)"
    }

    private func calculateFuel(from element: Int) -> Int {
        let mass = floor(Double(element) / 3.0) - 2
        return Int(mass)
    }
}
