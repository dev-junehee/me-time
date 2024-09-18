//
//  MainView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct MorningPaperView: View {
    
    private let repository = MorningPaperTableRepository()
    
    // private let filterList = [
    //     "This Week", "Latest 30", "January", "Feburary", "March", "April",
    //     "May", "June", "July", "August", "September", "October", "November", "December"
    // ]
    
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
    
    @State private var selectedFilter: MorningPaperFilterType = .all
    
    var body: some View {
        VStack(alignment: .leading) {
            titleView()
            filterScrollView()
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
            .padding(.top, 10)
            .padding(.horizontal, 20)
    }
    
    /// 필터 버튼 스크롤뷰
    private func filterScrollView() -> some View {
        ScrollView(.horizontal,  showsIndicators: false) {
            HStack {
                ForEach(MorningPaperFilterType.allCases, id: \.self) { item in
                    Button(action: {
                        print("\(item) 버튼 클릭")
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
        .padding(.leading, 20)
    }
    
}

#Preview {
    MorningPaperView()
}
