//
//  AgencyView.swift
//
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import CommonUI
import Leaderboard
import SwiftUI

struct AgencyView: SwiftUI.View {
    private var agency: Model

    init(agency: Model) {
        self.agency = agency
    }

    var body: some SwiftUI.View {
        HStack(spacing: 32) {
            Image(agency.location.imageName)
            VStack(alignment: .leading, spacing: 8) {
                Text(agency.location.name)
                    .semiBoldFont(size: 28, color: .text)

                Text(agency.scoreRepresentation)
                    .semiBoldFont(size: 20, color: .textSecondary)

                Text(agency.starsRepresentation)
                    .regularFont(size: 20, color: .textSecondary)

                Text(agency.participantsRepresentation)
                    .regularFont(size: 20, color: .textSecondary)

                Text(agency.scorePerParticipantRepresentation)
                    .semiBoldFont(size: 20, color: .textSecondary)
            }
            .padding(.vertical, 16)

            Spacer()
        }
        .padding(.leading, 16)
        .background(Color.background)
    }
}
