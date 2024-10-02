//
//  MainView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI
import RealmSwift

struct MorningPaperView: View {
    
    @Environment(\.isTabBarHidden) private var isTabBarHidden: Binding<Bool>
    
    private let repository = MorningPaperTableRepository()
    
    private enum MorningPaperFilterType: String, CaseIterable {
        case all = "All"
        case thisWeek = "This Week"
        case latest30 = "Latest 30"
        case positive = "Positive Emotion"
        case negative = "Negative Emotion"
    }
    
    /// 선택된 필터링 버튼
    @State private var selectedFilter: MorningPaperFilterType = .all
    
    @State private var showAlert = false
    
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
                    ForEach(groupedByMonth(filteredMorningPapers), id: \.key) { month, items in
                        Section(header: Text(month).font(.serifRegular16).foregroundStyle(.primaryBlack.opacity(0.7))) {
                            ForEach(items, id: \.id) { item in
                                if DateFormatterManager.isOneMonthOld(createAt: item.createAt) {
                                    morningPaperCell(item)
                                } else {
                                    morningPaperPrivateCell(item)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.bottom, 70)
            }
            .padding(.top, 20)
    }
    
    /// 모닝페이퍼 데이터를 월별로 그룹화
    private func groupedByMonth(_ papers: [MorningPaper]) -> [(key: String, value: [MorningPaper])] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM"
        
        let group = Dictionary(grouping: papers) { paper in
            formatter.string(from: paper.createAt)
        }
        
        return group.sorted { $0.key < $1.key }
    }
    
    /// 모닝페이퍼 데이터 셀 (공개)
    private func morningPaperCell(_ item: MorningPaper) -> some View {
        /// 일 / 요일
        let (day, dayOfWeek) = DateFormatterManager.getWeekDay(date: item.createAt)
        
        return NavigationLink {
            DetailView(detailData: item)
                .environment(\.isTabBarHidden, isTabBarHidden)
        } label: {
            HStack {
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
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.primaryGray)
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
            .foregroundStyle(.primaryBlack)
        }
    }
    
    /// 모닝페이퍼 데이터 셀 (비공개)
    private func morningPaperPrivateCell(_ item: MorningPaper) -> some View {
        /// 일 / 요일
        let (day, dayOfWeek) = DateFormatterManager.getWeekDay(date: item.createAt)
        
        return Button(action: {
            showAlert.toggle()
        }, label: {
            HStack {
                /// 날짜-요일
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
        })
        .foregroundStyle(.primaryBlack)
        .alert("조금 더 기다렸다 만나요. 🔐",
               isPresented: $showAlert,
               presenting: Constant.Button.alert) { (_, okay) in
            Button(okay) { showAlert.toggle() }
        }
    }
    
}

extension MorningPaperView {
    private var filteredMorningPapers: [MorningPaper] {
        switch selectedFilter {
        case .all:
            return Array(morningPaperList)
        case .thisWeek:
            let oneWeekAgo = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
            return morningPaperList.filter { $0.createAt >= oneWeekAgo }
        case .latest30:
            return Array(morningPaperList.prefix(30))
        case .positive:
            let positive = Constant.TodayEmotion.Positive.allCases.map { $0.rawValue }
            return morningPaperList.filter { positive.contains($0.emotion) }
        case .negative:
            let negative = Constant.TodayEmotion.Negative.allCases.map { $0.rawValue }
            return morningPaperList.filter { negative.contains($0.emotion) }
        }
    }
}
