//
//  TabView+LeaderboardStyle.swift
//
//
//  Created by Arnaud LE BOURBLANC on 26/11/2023.
//

import Foundation
import SwiftUI

public extension TabView {
    func tabViewLeaderboardStyle() -> some View {
        onAppear {
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(Color.textDisabled),
                NSAttributedString.Key.font: UIFont(name: "SourceCodePro-SemiBold", size: 10)
            ]
            itemAppearance.selected.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(Color.text),
                NSAttributedString.Key.font: UIFont(name: "SourceCodePro-SemiBold", size: 10)
            ]

            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().backgroundColor = UIColor(Color.background)
        }
    }
}

