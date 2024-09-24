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
    
    static func getFormattedTodayString(_ formatType: DateFormatType = .dot) -> String {
        let today = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = formatType.rawValue
        
        let convertedToday = formatter.string(from: today)
        return convertedToday
    }
    
    static func getFormattedDateString(date: Date, _ formatType: DateFormatType = .dot) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = formatType.rawValue
        
        let convertedToday = formatter.string(from: date)
        return convertedToday
    }
    
    static func getWeekDay(date: Date) -> (Int, String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") /// 미국/영국 고정 시간 표시
        formatter.dateFormat = "EE"
        
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)  /// 일
        let dayOfWeek = formatter.string(from: date)    /// 요일
        
        return (day, dayOfWeek.uppercased())
    }
    
}
