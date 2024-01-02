//
//  TabViewLeaderboardItem.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 26/11/2023.
//

import Foundation
import SwiftUI

public extension View {
    func tabViewLeaderboardItem(_ imageName: String, _ title: String, _ selected: Bool, _ tag: Int) -> some View {
        self.tabItem {
            Image(imageNameWithSelection(imageName: imageName, selected: selected))
            Text(title)
        }.tag(tag)
    }

    private func imageNameWithSelection(imageName: String, selected: Bool) -> String {
        return selected ? "\(imageName)Fill" : imageName
    }
}
