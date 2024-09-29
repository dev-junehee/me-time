//
//  SettingView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct SettingView: View {
    
    @State private var nickname = UserDefaultsManager.nick
    
    private enum AccountMenu: String, CaseIterable {
        case changeNickname = "닉네임 변경"
        case removeMorningPaper = "데이터 전체 삭제"
        case removeAccount = "계정 탈퇴"
    }
    
    private enum ApplicationMenu: String, CaseIterable {
        case checkVersion = "버전 확인"
        case openSource = "오픈소스 라이센스"
    }
    
    var body: some View {
        VStack {
            titleView()
            settingListView()
        }
        .background(.primaryGray)
        .onAppear {
            nickname = UserDefaultsManager.nick
        }
    }
    
    /// 상단 타이틀뷰
    private func titleView() -> some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Settings.")
                .font(.serifRegular40)
                .padding(.top, 20)
            Spacer()
            Text("Hello, \(nickname)!")
                .font(.gowunRegular14)
                
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .padding(.horizontal, 20)
    }
    
    /// 시스템 리스트 뷰
    private func settingListView() -> some View {
        List {
            accountMenuSection()
            applicationMenuSection()
        }
        .scrollContentBackground(.hidden) /// ListView 기본 배경 색상 없애기
    }
    
    /// 나의 계정 관리
    private func accountMenuSection() -> some View {
        Section {
            ForEach(AccountMenu.allCases, id: \.self) { item in
                NavigationLink {
                    ChangeNicknameView()
                } label: {
                    Text(item.rawValue)
                }
            }
        } header: {
            Text("나의 계정 관리")
        }
    }
    
    /// 앱 정보
    private func applicationMenuSection() -> some View {
        Section {
            ForEach(ApplicationMenu.allCases, id: \.self) { item in
                NavigationLink {
                    ChangeNicknameView()
                } label: {
                    Text(item.rawValue)
                }
            }
        } header: {
            Text("앱 정보")
        }
    }
    
}

#Preview {
    SettingView()
}
