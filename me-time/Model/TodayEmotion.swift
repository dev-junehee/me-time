//
//  TodayEmotion.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import Foundation

struct TodayEmotion: Hashable, Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool
}
