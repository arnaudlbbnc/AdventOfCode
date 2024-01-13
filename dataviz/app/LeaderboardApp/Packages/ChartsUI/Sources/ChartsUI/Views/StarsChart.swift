//
//  StarsChart.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import CommonUI
import Charts
import SwiftUI

struct StarsChart: SwiftUI.View {
    private let models: [StarsModel]

    private var maxStars: Int {
        models.map { $0.stars }.max() ?? 0
    }

    init(models: [StarsModel]) {
        self.models = models
    }

    var body: some SwiftUI.View {
        Chart {
            ForEach(models, id: \.day) { model in
                BarMark(
                    x: .value("Jour", model.day),
                    y: .value("Étoiles", model.stars)
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(Color.text)
                .annotation {
                    Text(verbatim: model.stars.formatted())
                        .semiBoldFont(size: 24)
                }
            }
        }
        .chartPlotStyle { plotContent in
            plotContent
                .background(Color.clear)
                .border(Color.text, width: 2)
        }
        .chartXScale(domain: [0, models.count+1])
        .chartYScale(domain: [0, maxStars+10])
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic) { value in
                AxisGridLine()
                    .foregroundStyle(Color.text)
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue)")
                            .regularFont(size: 18)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom, values: models.map{$0.day}) { value in
                if let intValue = value.as(Int.self), intValue % 5 == 0 {
                    AxisGridLine()
                        .foregroundStyle(Color.text)
                }
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue)")
                            .regularFont(size: 18)
                    }
                }
            }
        }
        .chartYAxisLabel(position: .topLeading) {
            Text("Étoiles")
                .semiBoldFont(size: 18)
                .rotationEffect(.degrees(270), anchor: .center)
                .offset(y: UIScreen.main.bounds.midY-75)
        }
        .chartXAxisLabel(position: .bottom, alignment: .center) {
            Text("Jours")
                .semiBoldFont(size: 18)
        }
    }
}
