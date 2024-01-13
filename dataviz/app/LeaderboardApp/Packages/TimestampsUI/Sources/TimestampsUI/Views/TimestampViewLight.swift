//
//  TimestampViewLight.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 02/01/2024.
//

import CommonUI
import SwiftUI

struct TimestampViewLight: SwiftUI.View {
    private var timestamp: TimestampModel

    init(timestamp: TimestampModel) {
        self.timestamp = timestamp
    }

    var body: some SwiftUI.View {
        HStack(spacing: 16) {
            Image(timestamp.imageName)
                .resizable()
                .frame(width: 60)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 2) {
                Text(timestamp.userName)
                    .semiBoldFont(size: 12)
                Text(timestamp.firstStarDurationRepresentation)
                    .regularFont(size: 10)
                Text(timestamp.secondStarDurationRepresentation)
                    .regularFont(size: 10)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 60)
        .background(Color.background)
    }
}
