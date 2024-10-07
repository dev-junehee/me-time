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
        case yearMonth = "YYYY MMMM"
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
    
    /// 모닝페이퍼  비공개 -> 공개 전환 확인용 (임시)
    static func isOneMinuteOld(createAt: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        // createdAt을 Date 객체로 변환
        guard let createAtDate = formatter.date(from: createAt) else {
            print("Invalid date format")
            return false
        }
        
        // 현재 시간 가져오기
        let today = Date()
        
        // 2분 후의 시간 계산
        let oneMinuteLater = createAtDate.addingTimeInterval(120)
        
        // 현재 시간이 1분 후를 지났는지 확인
        return today >= oneMinuteLater
    }
    
    static func isOneMonthOld(createAt: Date) -> Bool {
        // let formatter = DateFormatter()
        // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // formatter.locale = Locale(identifier: "en_US_POSIX")
        // 
        // guard let createAtDate = formatter.date(from: createAt) else {
        //     print("Invalid date format")
        //     return false
        // }
        
        let today = Date()
        
        if let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: createAt) {
            return today >= oneMonthLater
        }
        
        return false
    }
    
}
