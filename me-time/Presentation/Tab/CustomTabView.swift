//
//  TabView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

enum TabType {
    case main
    // case write
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
    @State private var selectedTab: TabType = .main
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .main:
                NavigationView {
                    MainView()
                }
            // case .write:
            //     NavigationView {
            //         WritingView()
            //     }
            case .data:
                NavigationView {
                    DataView()
                }
            case .music:
                NavigationView {
                    MusicView()
                }
            case .setting:
                NavigationView {
                    SettingView()
                }
            }
            CustomTabView(selectedTab: $selectedTab)
                .frame(height: 50)
        }
    }
}

struct CustomTabView: View {
    
    @Binding var selectedTab: TabType
    @State private var isWritingViewPresent = false
    
    var body: some View {
        ZStack {
            /// Tab 백그라운드 이미지
            Image(.tabBarBase)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 90)
                .offset(y: 5)
            
            /// Tab 버튼들
            HStack {
                Spacer()
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
                Spacer()
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
                Spacer()
                
                /// Floating
                Button(action: {
                    // selectedTab = .write
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
                
                Spacer()
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
                Spacer()
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
                Spacer()
            }
        }
    }
    
}
