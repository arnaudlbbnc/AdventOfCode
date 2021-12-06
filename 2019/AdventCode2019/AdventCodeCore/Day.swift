//
//  Day.swift
//  AdventCodeCore
//
//  Created by Arnaud Le Bourblanc on 02/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import Foundation

open class Day: Identifiable {
    open var number: Int { return 0 }

    open var status: DayStatus { return .notDone }

    public init() {
        loadInput()
    }
    
    open func getDataInput() -> Data? {
        guard let url = Bundle.main.url(forResource: "Day\(number)", withExtension: "txt"),
            let data = try? Data(contentsOf: url) else {
                return nil
        }
        return data
    }

    open func loadInput() {}

    open func getResult() -> String { return "" }
}
