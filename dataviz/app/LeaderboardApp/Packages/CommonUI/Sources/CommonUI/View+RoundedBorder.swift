//
//  View+RoundedBorder.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 26/11/2023.
//

import Foundation
import SwiftUI

public extension View {
    func roundedBorder(color: Color, width: CGFloat, radius: CGFloat = 16) -> some View {
        self.cornerRadius(radius)
            .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color, lineWidth: width)
        )
    }

    func roundedBorder(linearGradient: LinearGradient, width: CGFloat, radius: CGFloat = 16) -> some View {
        self.cornerRadius(radius)
            .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(linearGradient, lineWidth: width)
        )
    }
}
