//
//  TimestampView.swift
//
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import CommonUI
import Leaderboard
import SwiftUI

struct TimestampView: SwiftUI.View {
    private var timestamp: TimestampProtocol

    init(timestamp: TimestampProtocol) {
        self.timestamp = timestamp
    }

    var body: some SwiftUI.View {
        HStack(spacing: 16) {
//            Image(timestamp.user.imageName)
//                .resizable()
//                .frame(width: 100)
//                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 8) {
//                Text(timestamp.user.name)
//                    .semiBoldFont(size: 24)
                Text(timestamp.firstStarDurationRepresentation)
                    .regularFont(size: 20)
            }
            .padding(.vertical, 16)
            .padding(.trailing, 16)
        }
        .frame(height: 130)
        .background(Color.background)
    }
}
