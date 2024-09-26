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
    
    /// Realm 모닝페이퍼 데이터
    @ObservedResults(MorningPaper.self) var morningPaperList
    
    var body: some View {
        Chart(morningPaperList, id: \.id) { item in
            BarMark(x: .value("emotion", item.emotion), y: .value("content", item.content))
            // LineMark(x: .value("emotion", item.emotion), y: .value("content", item.description))
        }
        .frame(height: 300)
    }
    
}
