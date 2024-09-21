//
//  MainView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI
import RealmSwift

struct MorningPaperView: View {
    
    private let repository = MorningPaperTableRepository()
    
    private enum MorningPaperFilterType: String, CaseIterable {
        case all = "All"
        case thisWeek = "This Week"
        case latest30 = "Latest 30"
        case january = "January"
        case feburary = "Feburary"
        case march = "March"
        case april = "April"
        case may = "May"
        case june = "June"
        case july = "July"
        case august = "August"
        case septepber = "September"
        case october = "October"
        case november = "November"
        case december = "December"
    }
    
    /// 선택된 필터링 버튼
    @State private var selectedFilter: MorningPaperFilterType = .all
    
    /// Realm 모닝페이퍼 데이터 (`createAt`을 기준으로 내림차순 정렬 - 최신순)
    @ObservedResults(MorningPaper.self, sortDescriptor: SortDescriptor(keyPath: "createAt", ascending: false)) var morningPaperList
    
    var body: some View {
        VStack(alignment: .leading) {
            titleView()
            filterScrollView()
            morningPaperListView()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            print("메인 - ID", UserDefaultsManager.userID)
            print("메인 - nick", UserDefaultsManager.nick)
            repository.detectRealmURL()
        }
    }
    
    /// 상단 타이틀
    private func titleView() -> some View {
        Text("My Records.")
            .font(.serifRegular40)
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
    }
    
    /// 필터 버튼 스크롤뷰
    private func filterScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(MorningPaperFilterType.allCases, id: \.self) { item in
                    Button(action: {
                        selectedFilter = item
                    }, label: {
                        ZStack {
                            Capsule()
                                .fill(selectedFilter == item ? .primaryGreen : .primarySand.opacity(0.6))
                            Text(item.rawValue)
                                .baselineOffset(-4)
                                .font(.morenaBold14)
                                .foregroundStyle(.primaryBlack)
                                .padding(.horizontal, item == .all ? 24 : 16)
                        }
                    })
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .padding(.leading, 16)
    }
    
    /// 모닝페이퍼 데이터 리스트뷰
    private func morningPaperListView() -> some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(morningPaperList, id: \.id) { item in
                        /// 모닝페이퍼 생성 날짜가 현재보다 한달 이내이면 비공개 / 그 외는 공개
                        morningPaperCell(item)
                    }
                    /// (임시) 스크롤뷰 확인용
                    ForEach(0..<20) { item in
                        // morningPaperCell()
                        morningPaperPrivateCell()
                    }
                }
            }
            .padding(.top, 20)
    }
    
    /// 모닝페이퍼 데이터 셀 (공개)
    private func morningPaperCell(_ item: MorningPaper) -> some View {
        /// 일 / 요일
        let (day, dayOfWeek) = DateFormatterManager.getWeekDay(date: item.createAt)
        
        return HStack {
            ZStack {
                Rectangle()
                    .fill(.primarySand)
                    .cornerRadius(30, corners: [.topRight, .bottomRight])
                    .frame(width: 100, height: 100)
                VStack {
                    Text("\(day)")
                        .font(.serifRegular24)
                    Text(dayOfWeek)
                        .font(.serifRegular20)
                }
                .bold()
            }
            ZStack {
                Rectangle()
                    .fill(.primaryGray)
                    .cornerRadius(30, corners: [.topLeft, .bottomLeft, .topRight])
                    .overlay {
                        VStack(alignment: .leading) {
                            /// 감정 + 전체 날짜
                            HStack {
                                Text(item.emotion)
                                Text("•")
                                Text(DateFormatterManager.getFormattedDateString(date: item.createAt))
                            }
                            .font(.caption).opacity(0.5)
                            .position(x: 90, y: 10)
                            .frame(height: 20)
                            /// 제목
                            Text(item.title)
                                .frame(maxHeight: 50)
                                .multilineTextAlignment(.leading)
                                .font(.gowunRegular16)
                                .offset(x: 16)
                        }
                    }
            }
        }
        .padding(.trailing, 16)
    }
    
    /// 모닝페이퍼 데이터 셀 (비공개)
    private func morningPaperPrivateCell() -> some View {
        HStack {
            /// 날짜-요일
            ZStack {
                Rectangle()
                    .fill(.primarySand)
                    .cornerRadius(30, corners: [.topRight, .bottomRight])
                    .frame(width: 100, height: 100)
                VStack {
                    Text("03")
                        .font(.serifRegular24)
                    Text("SUN")
                        .font(.serifRegular20)
                }
                .bold()
            }
            ZStack {
                Rectangle()
                    .fill(.primaryGray)
                    .cornerRadius(30, corners: [.topLeft, .bottomLeft, .topRight])
                VStack(alignment: .center) {
                    Image(.lock)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("See You Later")
                        .font(.footnote)
                        .fontWeight(.light)
                }
            }
        }
        .padding(.trailing, 16)
    }
    
}
