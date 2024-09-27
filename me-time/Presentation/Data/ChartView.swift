//
//  ChartView.swift
//  me-time
//
//  Created by junehee on 9/25/24.
//

import SwiftUI
import Charts
import RealmSwift

struct ChartView: View {

    @Binding var filteredMorningPaperList: [MorningPaper]
    
    var body: some View {
        Chart(filteredMorningPaperList, id: \.id) { item in
            BarMark(x: .value("emotion", item.emotion), y: .value("content", item.content))
            // LineMark(x: .value("emotion", item.emotion), y: .value("content", item.description))
        }
        .frame(height: 300)
    }
    
}
