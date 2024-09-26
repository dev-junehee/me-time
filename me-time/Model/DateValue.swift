//
//  DateValue.swift
//  me-time
//
//  Created by junehee on 9/26/24.
//

import Foundation

struct DateValue: Identifiable {
    let id = UUID().uuidString
    let day: Int
    let date: Date
}
