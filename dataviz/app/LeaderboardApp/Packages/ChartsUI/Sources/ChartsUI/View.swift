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
            
            HStack {
                Image("sfeir")
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)

            HStack {
                Spacer()
                Text(viewModel.chartType.title)
                    .semiBoldFont(size: 32)
                Spacer()
            }
            .padding(.top, 75)

            GeometryReader { proxy in
                ForEach(Array(0...500), id: \.self) { _ in
                    Circle().fill(.white).frame(width: CGFloat.random(in: 1...3))
                        .padding(.leading, CGFloat.random(in: 1...proxy.size.width))
                        .padding(.top, CGFloat.random(in: 1...proxy.size.height))
                }

                chart
                    .padding(.top, 100)
                    .padding(.bottom, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 48)
            }
        }.task {
            await viewModel.retrieveData()
        }
    }

    @ViewBuilder private var chart: some SwiftUI.View {
        switch viewModel.chartType {
        case .stars:
            StarsChart(models: viewModel.starsModel)
        case .firstStar:
            DurationChart(models: viewModel.firstStarAverageDuration)
        case .secondStar:
            DurationChart(models: viewModel.secondStarAverageDuration)
        }
    }
}
