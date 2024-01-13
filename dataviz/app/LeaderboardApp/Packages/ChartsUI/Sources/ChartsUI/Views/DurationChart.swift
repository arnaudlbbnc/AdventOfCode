//
//  DurationChart.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 07/01/2024.
//

import Common
import Charts
import SwiftUI

struct DurationChart: SwiftUI.View {
    private let models: [StarDurationModel]

    private let firstStarMax: TimeInterval = 28800
    private let firstStarAxisLineValues = [0, 7200, 14400, 21600, 28800]
    private let secondStarMax: TimeInterval = 21600
    private let secondStarAxisLineValues = [0, 7200, 14400, 21600]

    init(models: [StarDurationModel]) {
        self.models = models
    }

    var body: some SwiftUI.View {
        Chart {
            ForEach(models, id: \.day) { model in
                LineMark(
                    x: .value("Jour", model.day),
                    y: .value("Durée", model.averageDuration)
                )
                .interpolationMethod(.catmullRom)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(Color.text)

                PointMark(
                    x: .value("Jour", model.day),
                    y: .value("Durée", model.averageDuration)
                )
                .foregroundStyle(Color.text)
            }
        }
        .chartPlotStyle { plotContent in
            plotContent
                .background(Color.clear)
                .border(Color.text, width: 2)
        }
        .chartXScale(domain: [0, models.count+1])
        .chartYScale(domain: [0, firstStarMax])
        .chartYAxis {
            AxisMarks(position: .leading, values: firstStarAxisLineValues) { value in
                AxisGridLine()
                    .foregroundStyle(Color.text)
                AxisValueLabel() {
                    if let timeInterval = value.as(TimeInterval.self),
                       let timeIntervalRepresentation = timeInterval.durationRepresentation {
                        Text(timeIntervalRepresentation)
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
            Text("Durée")
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
