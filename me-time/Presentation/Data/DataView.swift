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
                if filteredMorningPaperList.isEmpty {
                    emptyView()
                } else {
                    ChartView(filteredMorningPaperList: $filteredMorningPaperList)
                }
            }
        }
        .padding(.top, 1)  /// SafeArea
        .padding(.bottom, 80)
    }
    
    /// 모닝페이퍼 데이터가 없을 경우 차트 대신 렌더링
    private func emptyView() -> some View {
        Text("아직 보여줄 데이터가 없어요! 😶‍🌫️")
            .font(.gowunRegular14)
    }
    
}
