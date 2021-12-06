//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore

class Day6: Day {
    override var number: Int { return 6 }

    override var status: DayStatus { return .done }

    var input: [String: [String]]!

    var counter: Int = 0

    var you: Foo!
    var santa: Foo!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let elements = str.components(separatedBy: .newlines).filter({!$0.isEmpty})
        var map: [String: [String]] = [:]
        for element in elements {
            let components = element.components(separatedBy: ")")
            let key = components[0]
            let value = components[1]
            if map[key] == nil {
                map[key] = [value]
            } else {
                map[key]?.append(value)
            }
        }
        self.input = map
    }

    override func getResult() -> String {
//        let value = getStepOne(input: input)
        let value = getStepTwo(input: input)
        return "\(value)"
    }

    private func getStepOne(input: [String: [String]]) -> Int {
        let start = Foo(name: "COM", before: nil, count: 0)

        getAfter(from: start, and: input)

        return counter
    }

    private func getStepTwo(input: [String: [String]]) -> Int {
        let start = Foo(name: "COM", before: nil, count: 0)

        getAfter(from: start, and: input)

        let pathCount = getPathCount(left: you, right: santa)

        return pathCount
    }

    func getAfter(from foo: Foo, and input: [String: [String]]) {
        if foo.name == "YOU" {
            you = foo
        } else if foo.name == "SAN" {
            santa = foo
        }

        let afters = input[foo.name]?.map({Foo(name: $0, before: foo, count: foo.count+1)}) ?? []
        foo.after = afters

        counter += afters.reduce(0, {return $0+$1.count})
        for after in afters {
            getAfter(from: after, and: input)
        }
    }

    func getPathCount(left: Foo, right: Foo) -> Int {
        let leftAncestors = Set(left.getAncestors())
        let rightAncestors = Set(right.getAncestors())

        let intersection = leftAncestors.intersection(rightAncestors)
        if let mostAncestors = intersection.max(by: {return $0.count < $1.count}) {
            return left.count - mostAncestors.count + right.count - mostAncestors.count - 2
        } else {
            return 0
        }
    }

    class Foo: Equatable, Hashable, CustomStringConvertible {
        var name: String
        var before: Foo?
        var after: [Foo] = []
        var count: Int

        init(name: String, before: Foo?, count: Int) {
            self.name = name
            self.before = before
            self.count = count
        }

        static func ==(lhs: Foo, rhs: Foo) -> Bool {
            return lhs.name == rhs.name
        }

        var description: String {
            return name + " -> " + (before?.description ?? "")
        }

        func getAncestors() -> [Foo] {
            var ancestor = self.before
            var ancestors: [Foo] = []
            while ancestor != nil {
                ancestors.append(ancestor!)
                ancestor = ancestor?.before
            }
            return ancestors
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
    }
}
