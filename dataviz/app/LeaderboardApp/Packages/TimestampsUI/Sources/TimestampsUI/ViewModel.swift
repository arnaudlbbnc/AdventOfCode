//
//  ViewModel.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 25/11/2023.
//

import Foundation
import Leaderboard

final class ViewModel: ObservableObject {
    @Published private(set) var model = Model()
    private let interactor = Interactor()

    @MainActor
    func retrieveTimestamps() async {
        model = await interactor.retrieveTimestamps() ?? Model()
    }
}
