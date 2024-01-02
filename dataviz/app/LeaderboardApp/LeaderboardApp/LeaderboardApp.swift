//
//  LeaderboardApp.swift
//  LeaderboardApp
//
//  Created by Arnaud LE BOURBLANC on 05/11/2023.
//

import ContainerUI
import Dependency
import SwiftUI

@main
struct LeaderboardApp: App {
    init() {
        Dependency.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContainerUI.View()
        }
    }
}
