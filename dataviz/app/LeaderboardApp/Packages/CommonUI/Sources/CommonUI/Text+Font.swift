//
//  Text+Font.swift
//
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import SwiftUI

public extension Text {
    func regularFont(size: CGFloat, color: Color = .text) -> some View {
        self.font(Font.custom("SourceCodePro-Regular", size: size))
            .foregroundStyle(color)
    }

    func semiBoldFont(size: CGFloat, color: Color = .text) -> some View {
        self.font(Font.custom("SourceCodePro-SemiBold", size: size))
            .foregroundStyle(color)
    }
}
