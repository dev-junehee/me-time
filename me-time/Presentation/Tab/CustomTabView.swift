//
//  TabView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

enum TabType {
    case main
    case data
    case music
    case setting
}

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ContentView: View {
    
    @State private var isTabBarHidden: Bool = false
    @State private var selectedTab: TabType = .main
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .main:
                NavigationView {
                    MorningPaperView()
                        .environment(\.isTabBarHidden, $isTabBarHidden)
                }
            case .data:
                NavigationView {
                    DataView()
                }
            case .music:
                NavigationView {
                    MusicView()
                        .environment(\.isTabBarHidden, $isTabBarHidden)
                }
            case .setting:
                NavigationView {
                    SettingView()
                        .environment(\.isTabBarHidden, $isTabBarHidden)
                }
            }
            VStack {
                Spacer()
                CustomTabView(selectedTab: $selectedTab)
                    .frame(height: 50)
                    .padding(.bottom, 1)
                    .opacity(isTabBarHidden ? 0 : 1)
            }
            .padding(.bottom, 10)
        }
    }
    
}

struct CustomTabView: View {
    
    @Binding var selectedTab: TabType
    @State private var isWritingViewPresent = false
    
    var body: some View {
        ZStack {
            tabBackgroundImage()
            tabButtons()
        }
    }
    
    /// 탭 백그라운드 이미지
    private func tabBackgroundImage() -> some View {
        Image(.tabBarBase)
            .resizable()
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .offset(y: 5)
    }
    
    /// 탭 버튼들
    private func tabButtons() -> some View {
        HStack {
            Spacer()
            mainTapButton()
            Spacer()
            dataTapButton()
            Spacer()
            writeFloatingButton()
            Spacer()
            musicTapButton()
            Spacer()
            settingTapButton()
            Spacer()
        }
    }
    
    /// 메인 탭 버튼
    private func mainTapButton() -> some View {
        Button(action: {
            selectedTab = .main
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(selectedTab == .main ? .primaryGreen : .clear)
                    .frame(width: 40, height: 40)
                Image(.grid)
            }
        })
    }
    
    /// 데이터 탭 버튼
    private func dataTapButton() -> some View {
        Button(action: {
            selectedTab = .data
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(selectedTab == .data ? .primaryGreen : .clear)
                    .frame(width: 40, height: 40)
                Image(.chart)
            }
        })
    }
    
    /// 글쓰기 플로팅 버튼
    private func writeFloatingButton() -> some View {
        Button(action: {
            isWritingViewPresent.toggle()
        }, label: {
            ZStack {
                Circle()
                    .foregroundStyle(.primarySand)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 2)
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.primaryBlack)
                    .frame(width: 20, height: 20)
            }
            .offset(x: 5, y: -32)
        })
        .buttonStyle(TabButtonStyle())
        .fullScreenCover(isPresented: $isWritingViewPresent,
                         content: {
            WritingView(isWritingViewPresent: $isWritingViewPresent)
        })
    }
    
    /// 음악 추천 탭 버튼
    private func musicTapButton() -> some View {
        Button(action: {
            selectedTab = .music
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(selectedTab == .music ? .primaryGreen : .clear)
                    .frame(width: 40, height: 40)
                Image(.disc)
            }
        })
    }
    
    /// 설정 탭 버튼
    private func settingTapButton() -> some View {
        Button(action: {
            selectedTab = .setting
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(selectedTab == .setting ? .primaryGreen : .clear)
                    .frame(width: 40, height: 40)
                Image(.settings)
            }
        })
    }
    
}
