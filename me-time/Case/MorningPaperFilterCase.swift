//
//  MorningPaperFilterCase.swift
//  me-time
//
//  Created by junehee on 10/25/24.
//

import Foundation

/// 모닝페이퍼 데이터 필터링 케이스
enum MorningPaperFilterCase: String, CaseIterable {
    case all = "All"
    case thisWeek = "This Week"
    case latest30 = "Latest 30"
    case positive = "Positive Emotion"
    case negative = "Negative Emotion"
}
