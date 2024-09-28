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
        let data = countEmotion().map { (emotion: $0.key, count: $0.value) }
        
        Chart(data, id: \.emotion) { item in
            BarMark(x: .value("emotion", item.emotion), y: .value("count", item.count))
        }
        .frame(height: 300)
        .foregroundStyle(.primarySand)
        .onAppear {
            print(filteredMorningPaperList)
        }
        .padding(.horizontal, 16)
    }
    
    /// 각 달의 모닝페이퍼 데이터 순회 - 각 감정이 몇 번인지 카운트
    private func countEmotion() -> [String: Int] {
        var countDict: [String: Int] = [:]
        for morningPaper in filteredMorningPaperList {
            countDict[morningPaper.emotion, default: 0] += 1
        }
        print("countDict", countDict)
        return countDict
    }
    
}
