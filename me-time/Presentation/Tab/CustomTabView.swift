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
                DataView()
                    .tabItem {
                        Image(.chart)
                    }
                MusicView()
                    .tabItem {
                        Image(.disc)
                    }
                SettingView()
                    .tabItem {
                        Image(.settings)
                    }
            }
        }
    }
}

#Preview {
    CustomTabView()
}
