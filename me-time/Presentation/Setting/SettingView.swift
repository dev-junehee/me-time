//
//  SettingView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct SettingView: View {
    
    @State private var nickname = UserDefaultsManager.nick
    
    @Environment(\.openURL) var openURL
    
    private let email = Email(address: "dev.junehee@gmail.com", subject: "[미타임] 문의하기")
    
    private enum AccountMenu: String, CaseIterable {
        case changeNickname = "닉네임 변경"
        case removeMorningPaper = "데이터 전체 삭제"
        case removeAccount = "계정 탈퇴"
    }
    
    private enum ApplicationMenu: String, CaseIterable {
        case checkVersion = "버전 정보"
        case openSource = "오픈소스 라이센스"
        case feedback = "피드백 보내기"
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
            ForEach(AccountMenu.allCases, id: \.self) { menu in
                switch menu {
                case .changeNickname:
                    NavigationLink {
                        ChangeNicknameView()
                    } label: {
                        Text(menu.rawValue)
                    }
                case .removeMorningPaper:
                    Text(menu.rawValue)
                case .removeAccount:
                    Text(menu.rawValue)
                }
            }
            .foregroundStyle(.primaryBlack)
        } header: {
            Text("나의 계정 관리")
        }
    }
    
    /// 앱 정보
    private func applicationMenuSection() -> some View {
        Section {
            ForEach(ApplicationMenu.allCases, id: \.self) { menu in
                switch menu {
                case .checkVersion:
                    HStack {
                        Text(menu.rawValue)
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.primaryBlack.opacity(0.5))
                    }
                case .openSource:
                    Button(action: {
                        if let URL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(URL) {
                            openURL(URL)
                        }
                    }, label: {
                        Text(menu.rawValue)
                    })
                case .feedback:
                    Button(action: {
                        email.sendEmail(openURL: openURL)
                    }, label: {
                        Text(menu.rawValue)
                    })
                }
            }
            .foregroundStyle(.primaryBlack)
        } header: {
            Text("앱 정보")
        }
    }
    
}

#Preview {
    SettingView()
}
