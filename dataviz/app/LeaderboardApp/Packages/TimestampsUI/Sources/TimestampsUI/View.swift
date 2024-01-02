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
//                HStack {
//                    VStack(spacing: 32) {
//                        if let total = viewModel.total {
//                            AgencyView(agency: total)
//                                .frame(width: proxy.size.width / 2)
//                                .roundedBorder(color: .text, width: 5)
//                        }
//
//                        FlowLayout(spacing: 32) {
//                            ForEach(Array(viewModel.agencies.enumerated()), id: \.0) { (_, agency) in
//                                AgencyView(agency: agency)
//                                    .frame(width: (proxy.size.width / 2 - 50))
//                                    .roundedBorder(color: .textSecondary, width: 5)
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .padding(.vertical, 64)
//                    .padding(.horizontal, 16)
//                }
            }
        }.task {
            await viewModel.retrieveTimestamps()
        }
    }
}
