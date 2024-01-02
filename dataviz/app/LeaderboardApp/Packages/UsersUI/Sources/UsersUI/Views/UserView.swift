//
//  UserView.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import CommonUI
import Leaderboard
import SwiftUI

struct UserView: SwiftUI.View {
    private var user: Model

    init(user: Model) {
        self.user = user
    }

    var body: some SwiftUI.View {
        HStack(spacing: 16) {
            Image(user.imageName)
                .resizable()
                .frame(width: 100)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name)
                    .semiBoldFont(size: 24)
                Text(user.scoreRepresentation)
                    .regularFont(size: 20)
            }
            .padding(.vertical, 16)
            .padding(.trailing, 16)
        }
        .frame(height: 100)
        .background(Color.background)
    }
}
