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
    @Published var starsModel = [StarsModel]()
    @Published var firstStarAverageDuration = [StarDurationModel]()
    @Published var secondStarAverageDuration = [StarDurationModel]()
    let chartType = ChartType.firstStar
    private let interactor = Interactor()

    @MainActor
    func retrieveData() async {
        switch chartType {
        case .stars:
            await retrieveStarsData()
        case .firstStar:
            await retrieveFirstStarData()
        case .secondStar:
            await retrieveSecondStarData()
        }
    }

    @MainActor
    private func retrieveStarsData() async {
        starsModel = await interactor.retrieveTotalStarsPerDay() ?? []
    }

    @MainActor
    private func retrieveFirstStarData() async {
        firstStarAverageDuration = await interactor.retrieveFirstStarDurationPerDay() ?? []
    }

    @MainActor
    private func retrieveSecondStarData() async {
        secondStarAverageDuration = await interactor.retrieveSecondStarDurationPerDay() ?? []
    }
}
