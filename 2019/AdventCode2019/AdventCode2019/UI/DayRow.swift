//
//  DayRow.swift
//  AdventCode2019
//
//  Created by Arnaud Le Bourblanc on 02/12/2019.
//  Copyright © 2019 Arnaud Le Bourblanc. All rights reserved.
//

import SwiftUI
import AdventCodeCore

struct DayRow: View {
    var day: Day

    var body: some View {
            HStack {
                HStack {
                    Text("Day \(day.number)").font(Font.system(size: 20.0))
                    Text("-")
                    Text(day.getResult()).font(Font.system(size: 20.0))
                }
                Spacer()
                day.status.getImage().resizable().frame(width: 32.0, height: 32.0)
            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

    }
}

struct DayRow_Previews: PreviewProvider {
    static var previews: some View {
        DayRow(day: Day1())
    }
}
