//
//  UserViewLight.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 27/11/2023.
//

import CommonUI
import SwiftUI

struct UserViewLight: SwiftUI.View {
    private var user: Model

    init(user: Model) {
        self.user = user
    }

    var body: some SwiftUI.View {
        HStack(spacing: 16) {
            Image(user.imageName)
                .resizable()
                .frame(width: 45)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 2) {
                Text(user.name)
                    .semiBoldFont(size: 14)
                Text(user.scoreRepresentation)
                    .regularFont(size: 12)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 45)
        .background(Color.background)
    }
}
