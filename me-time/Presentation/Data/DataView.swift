//
//  DataView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI
import RealmSwift

struct DataView: View {
    
    /// 오늘 날짜
    @State var currentData = Date()
    /// 사용자가 선택한 날짜
    @State var selectedData = Data()
    
    /// Realm - MorningPaper 데이터 리스트
    @ObservedResults(MorningPaper.self) var morningPaperList
    @State var filteredMorningPaperList: [MorningPaper] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CustomCalendarView(currentDate: $currentData,
                                   morningPaperList: $morningPaperList, 
                                   filteredMorningPaperList: $filteredMorningPaperList)
                ChartView(filteredMorningPaperList: $filteredMorningPaperList)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, 80)
    }
}
