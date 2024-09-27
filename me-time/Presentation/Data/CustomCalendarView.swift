//
//  CustomCalendarView.swift
//  me-time
//
//  Created by junehee on 9/25/24.
//

import SwiftUI
import RealmSwift

struct CustomCalendarView: View {
    
    /// DateView에서 내려오는 오늘 날짜, 모닝페이퍼 리스읕
    @Binding var currentDate: Date
    
    /// 사용자가 월 버튼으로 선택한 값
    @State private var currentMonth: Int = 0
    
    @ObservedResults(MorningPaper.self) var morningPaperList: Results<MorningPaper>
    
    /// 필터링된 모닝페이퍼 데이터
    @Binding var filteredMorningPaperList: [MorningPaper]
    
    // /// Realm - MorningPaper 데이터 리스트
    // @ObservedResults(MorningPaper.self) var morningPaperList
    
    private enum Days: String, CaseIterable {
        case SUN, MON, TUE, WED, THU, FRI, SAT
    }
    
    var body: some View {
        VStack(spacing: 15) {
            /// Year, Month
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(extraDate()[0])
                        // .font(.callout.bold())
                        .font(.serifRegular20)
                    Text(extraDate()[1])
                        // .font(.title)
                        .font(.serifRegular30)
                        .baselineOffset(8)
                        // .bold()
                }
                
                Spacer()
                
                HStack(spacing: 24) {
                    /// 캘린더 : 이전 달로 이동
                    Button(action: {
                        withAnimation { currentMonth -= 1 }
                    }, label: {
                        Image(systemName: "chevron.left").font(.title2)
                    })
                    /// 캘린더 : 다음 달로 이동
                    Button(action: {
                        withAnimation { currentMonth += 1 }
                    }, label: {
                        Image(systemName: "chevron.right").font(.title2)
                    })
                }
                .foregroundStyle(.primaryBlack.opacity(0.5))
                
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
            /// Days (`월~일`)
            HStack(spacing: 0) {
                ForEach(Days.allCases, id: \.self) { day in
                    Text(day.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(day.rawValue == "SUN" ? .red : day.rawValue == "SAT" ? .blue : .primaryBlack)
                }
            }
            
            /// Dates (`1~31`)
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    cardView(value)
                        .background {
                            Capsule()
                                .fill(.primaryGreen)
                                .padding([.top, .horizontal], 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                .frame(height: 64)
                        }
                        .onTapGesture {
                            /// 날짜 클릭 시 currentDate 변경
                            currentDate = value.date
                            print("currentDate 변경 >>", currentDate)
                        }
                }
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 20)
        }
        .onAppear(perform: filterMorningPaper)
        .onChange(of: currentMonth) { newValue in
            /// 캘린더 이동 시 날짜 업데이트
            currentDate = getCurrentMonth()
            filterMorningPaper()
        }
    }
    
    /// 월별 날짜 텍스트
    @ViewBuilder
    func cardView(_ dateValue: DateValue) -> some View {
        VStack {
            if dateValue.day != -1 {
                Text("\(dateValue.day)")
                    .font(.callout)
                /// dateValue.date와 일치하는 모닝페이퍼 날짜의 이모지 출력
                Text(getDateEmotionEmoji(date: dateValue.date))
                    .font(.caption)
            } else {
                Text("")
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 40, alignment: .top)
    }
    
    /// 현재 선택된 달(Month)로 모닝페이퍼 데이터 필터링
    func filterMorningPaper() {
        let calendar = Calendar.current
        
        /// 이번 달 시작 날짜, 마지막 날짜
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!

        filteredMorningPaperList = morningPaperList.filter {
            return $0.createAt >= startOfMonth && $0.createAt <= endOfMonth
        }
    }
    
    /// Checking Dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    /// 현재 캘린더 연/월 구하기 (DateFormatter로 이동하기!)
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    /// Get Month Date
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDate().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        /// Add offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        // dump(days)
        return days
    }
    
    /// 각 날짜에 맞는 모닝페이퍼의 이모지 출력
    func getDateEmotionEmoji(date: Date) -> String {
        let startOfDay = date.startOfDay()
        
        for morningPaper in morningPaperList {
            if startOfDay == morningPaper.createAt.startOfDay() {
                let emotion = morningPaper.emotion
                let emoji = Constant.TodayEmotion.AllEmotions(rawValue: emotion)?.emotionEmoji
                return emoji ?? ""
            }
        }
        
        return ""
    }

    
}

extension Date {
    func getAllDate() -> [Date] {
        let calendar = Calendar.current
        
        /// Start Date
        guard let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else { return [] }
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
