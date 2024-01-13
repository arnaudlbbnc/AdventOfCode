//
//  TimestampView.swift
//
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import CommonUI
import SwiftUI

struct TimestampView: SwiftUI.View {
    private var timestamp: TimestampModel

    init(timestamp: TimestampModel) {
        self.timestamp = timestamp
    }

    var body: some SwiftUI.View {
        HStack(spacing: 16) {
            Image(timestamp.imageName)
                .resizable()
                .frame(width: 100)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 4) {
                Text(timestamp.userName)
                    .semiBoldFont(size: 22)
                Text(timestamp.firstStarDurationRepresentation)
                    .regularFont(size: 18)
                Text(timestamp.secondStarDurationRepresentation)
                    .regularFont(size: 18)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 100)
        .background(Color.background)
    }
}
