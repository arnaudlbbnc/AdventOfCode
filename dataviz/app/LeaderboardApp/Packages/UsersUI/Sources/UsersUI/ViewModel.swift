//
//  ViewModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard

final class ViewModel: ObservableObject {
    @Published private(set) var structure = Structure.vide()
    private let interactor = Interactor()

    @MainActor
    func retrieveUsers() async {
        let users = await interactor.retrieveUsers()
        let models = users?.enumerated()
            .map { (index: Int, user: UserProtocol) in
                Model(id: user.id,
                      rank: index + 1,
                      name: "\(user.firstname) \(user.lastname)",
                      score: user.score,
                      stars: user.stars)
            } ?? []
        structure = Structure.from(models: models)
    }
}
