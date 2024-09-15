//
//  TabView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                MainView()
                    .tabItem {
                        Image(.grid)
                    }
                    .tag(0)
                DataView()
                    .tabItem {
                        Image(.chart)
                    }
                    .tag(1)
                MusicView()
                    .tabItem {
                        Image(.disc)
                    }
                    .tag(2)
                SettingView()
                    .tabItem {
                        Image(.settings)
                    }
                    .tag(3)
            }
        }
    }
}

#Preview {
    CustomTabView()
}
