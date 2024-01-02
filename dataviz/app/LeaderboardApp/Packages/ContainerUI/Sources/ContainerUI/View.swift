//
//  View.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import AgenciesUI
import CommonUI
import Leaderboard
import SwiftUI
import TimestampsUI
import UsersUI

public struct View: SwiftUI.View {
    public init() {}
    
    public var body: some SwiftUI.View {
        TimestampsUI.View()
//        UsersUI.View()
//        AgenciesUI.View()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .statusBar(hidden: true)
    }
}
