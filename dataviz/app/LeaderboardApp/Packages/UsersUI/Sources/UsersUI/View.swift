//
//  View.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import CommonUI
import SwiftUI

public struct View: SwiftUI.View {
    @ObservedObject private var viewModel: ViewModel

    public init() {
        self.viewModel = ViewModel()
    }

    public var body: some SwiftUI.View {
        ZStack(alignment: .topLeading) {
            Color.background
                .ignoresSafeArea()
            Image("sfeir")
                .padding([.leading, .top], 16)
            GeometryReader { proxy in
                ForEach(Array(0...500), id: \.self) { _ in
                    Circle().fill(.white).frame(width: CGFloat.random(in: 1...3))
                        .padding(.leading, CGFloat.random(in: 1...proxy.size.width))
                        .padding(.top, CGFloat.random(in: 1...proxy.size.height))
                }
                VStack(spacing: 32) {
                    if let firstUser = viewModel.structure.first {
                        UserView(user: firstUser)
                            .roundedBorder(linearGradient: .gold, width: 5)
                    }
                    if let secondUser = viewModel.structure.second,
                       let thirdUser = viewModel.structure.third {
                        HStack(spacing: 48) {
                            UserView(user: secondUser)
                                .roundedBorder(linearGradient: .silver, width: 5)
                            UserView(user: thirdUser)
                                .roundedBorder(linearGradient: .bronze, width: 5)
                        }
                    }

                    FlowLayout(spacing: 18) {
                        ForEach(Array(viewModel.structure.rest.enumerated()), id: \.0) { (_, user) in
                            UserViewLight(user: user)
                                .roundedBorder(color: .textDisabled, width: 2)
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 64)
                .padding(.horizontal, 16)
            }
        }.task {
            await viewModel.retrieveUsers()
        }
    }
}
