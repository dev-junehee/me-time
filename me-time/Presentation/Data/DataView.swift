//
//  DataView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct DataView: View {
    
    @State var currentData: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CalendarView()
                // CustomCalendarView(currentDate: $currentData)
                // ChartView()
            }
        }
    }
}
