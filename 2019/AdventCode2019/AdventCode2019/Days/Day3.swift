//
//  Day2.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 03/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import AdventCodeCore
import Foundation

class Day3: Day {
    override var number: Int { return 3 }

    override var status: DayStatus { return .done }

    private var input: [[Direction]]!

    override func loadInput() {
        guard let data = getDataInput(),
            let str = String(data: data, encoding: .utf8) else {
            return
        }
        let paths = str.components(separatedBy: .newlines)
        let wires = paths.map({$0.components(separatedBy: ",").compactMap({Direction(from: $0)})})
        self.input = wires
    }

    override func getResult() -> String {
        let leftWire = self.input[0]
        let rightWire = self.input[1]
        let leftPoints = calculatePoints(for: leftWire)
        let rightPoints = calculatePoints(for: rightWire)
        let intersections = getIntersections(between: leftPoints, and: rightPoints)
//        let manhattanDistances = intersections.map({calculateManhattanDistance(for: $0)})
        let steps = intersections.map({$0.steps})
        return "\(steps.min() ?? 0)"
    }

    private func calculatePoints(for directions: [Direction]) -> [Point] {
        var x = 0
        var y = 0
        var points = [Point]()
        var steps = 0
        for direction in directions {
            let value = direction.getValue()
            for _ in 0..<value {
                steps += 1
                switch direction {
                case .left, .right:
                    direction.calculate(position: &x, value: 1)
                case .down, .up:
                    direction.calculate(position: &y, value: 1)
                }
                points.append(Point(x: x, y: y, steps: steps))
            }
        }
        return points
    }

    private func getIntersections(between leftArray: [Point], and rightArray: [Point]) -> [Point] {
        let leftSet = Set(leftArray)
        let rightSet = Set(rightArray)
        var intersections = Array(leftSet.intersection(rightSet))
        intersections = intersections.map({ (point: Point) in
            var point = point
            let rightPoint = rightSet.first(where: {$0==point})
            point.steps += rightPoint?.steps ?? 0
            return point
        })

        return intersections
    }

    private func calculateManhattanDistance(for point: Point) -> Int {
        let absX = abs(point.x)
        let absY = abs(point.y)
        return absX + absY
    }

    private enum Direction {
        case left(Int)
        case right(Int)
        case down(Int)
        case up(Int)

        init?(from str: String) {
            guard let direction = str.first,
                let value = Int(String(str.dropFirst())) else {
                    return nil
            }

            switch direction {
            case "L":
                self = .left(value)
            case "R":
                self = .right(value)
            case "D":
                self = .down(value)
            case "U":
                self = .up(value)
            default:
                return nil
            }
        }

        func getValue() -> Int {
            switch self {
            case .left(let value), .right(let value), .down(let value), .up(let value):
                return value
            }
        }

        func calculate(position: inout Int, value: Int) {
            switch self {
            case .left, .down:
                position += value
            case .right, .up:
                position -= value
            }
        }
    }

    struct Point: Hashable, Equatable {
        var x: Int
        var y: Int
        var steps: Int

        static func ==(lhs: Point, rhs: Point) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(x)
            hasher.combine(y)
        }
    }
}
