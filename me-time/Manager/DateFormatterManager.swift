//
//  DateManager.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import Foundation

struct DateFormatterManager {
    
    enum DateFormatType: String {
        case dot = "yyyy. MM. dd"
        case dash = "yyyy-MM-dd"
    }
    
    static func getTodayString(formatType: DateFormatType = .dot) -> String {
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = formatType.rawValue
        
        let convertedToday = dateFormatter.string(from: today)
        return convertedToday
    }
    
}
