//
//  Array+Safe.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 17/12/2023.
//

import Foundation

public extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript(safe range: Range<Index>) -> [Element] {
        if range.endIndex > endIndex {
            if range.startIndex >= endIndex { return [] }
            else { return Array(self[range.startIndex..<endIndex]) }
        } else {
            return Array(self[range])
        }
    }
}
