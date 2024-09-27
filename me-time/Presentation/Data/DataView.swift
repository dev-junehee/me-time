//
//  DataView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct DataView: View {
    
    @State var currentData = Date()
    
    var body: some View {
        // VStack {
        //     CustomCalendarView(currentDate: $currentData)
        //     ScrollView(.vertical, showsIndicators: false) {
        //         ChartView()
        //     }
        // }
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // CalendarView()
                CustomCalendarView(currentDate: $currentData)
                ChartView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, 80)
    }
}
