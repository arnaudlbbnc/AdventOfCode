//
//  AppGradients.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 29/11/2023.
//

import Foundation
import SwiftUI

public extension LinearGradient {
    static var gold: LinearGradient {
        let colors = [
            Color(hex: "#DBB400"),
            Color(hex: "#EFAF00"),
            Color(hex: "#F5D100"),
            Color(hex: "#F5D100"),
            Color(hex: "#D1AE15"),
            Color(hex: "#DBB400"),
        ].compactMap { $0 }
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    static var silver: LinearGradient {
        let colors = [
            Color(hex: "#70706F"),
            Color(hex: "#7D7D7A"),
            Color(hex: "#B3B6B5"),
            Color(hex: "#8E8D8D"),
            Color(hex: "#B3B6B5"),
            Color(hex: "#A1A2A3"),
        ].compactMap { $0 }
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    static var bronze: LinearGradient {
        let colors = [
            Color(hex: "#804A00"),
            Color(hex: "#9C7A3C"),
            Color(hex: "#B08D57"),
            Color(hex: "#895E1A"),
            Color(hex: "#804A00"),
            Color(hex: "#B08D57"),
        ].compactMap { $0 }
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    static var green: LinearGradient {
        let colors = [
            Color(hex: "#00CC00")
        ].compactMap { $0 }
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
