//
//  MainView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Text("MainView")
            .onAppear {
                print("메인 - ID", UserDefaultsManager.userID)
                print("메인 - nick", UserDefaultsManager.nick)
            }
    }
}

#Preview {
    MainView()
}
