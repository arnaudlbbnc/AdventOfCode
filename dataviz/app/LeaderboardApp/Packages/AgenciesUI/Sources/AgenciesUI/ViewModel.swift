//
//  ViewModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard

final class ViewModel: ObservableObject {
    @Published private(set) var agencies = [Model]()
    @Published private(set) var total: Model?
    private let interactor = Interactor()

    @MainActor
    func retrieveAgencies() async {
        let agencies = await interactor.retrieveAgencies() ?? []
        self.agencies = agencies.map { (agency: AgencyProtocol) in
            Model(location: agency.location, participants: agency.participants, score: agency.score, stars: agency.stars)
        }
        self.total = Model(location: .sfeir, 
                          participants: agencies.reduce(0) { $0 + $1.participants },
                          score: agencies.reduce(0) { $0 + $1.score },
                          stars: agencies.reduce(0) { $0 + $1.stars })
    }
}
