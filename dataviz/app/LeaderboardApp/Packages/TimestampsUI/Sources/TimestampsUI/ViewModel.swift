//
//  ViewModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard
import SwiftUI

final class ViewModel: ObservableObject {
    @Published private(set) var model = Model()
    private let interactor = Interactor()

    @MainActor
    func retrieveTimestamps(day: Int = 1) async {
        guard day <= 25 else { return }
        let model = await interactor.retrieveTimestamps(day: day) ?? Model()
        try? await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        self.model = model
        await retrieveTimestamps(day: day+1)
    }

    func color(for rank: Int) -> LinearGradient {
        switch rank {
        case 0:
            return .gold
        case 1:
            return .silver
        case 2:
            return .bronze
        default:
            return .green
        }
    }
}
