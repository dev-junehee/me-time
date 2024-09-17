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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
            .onAppear {
                print("메인 - ID", UserDefaultsManager.userID)
                print("메인 - nick", UserDefaultsManager.nick)
            }
    }
}

#Preview {
    MainView()
}
