//
//  OnboardingView.swift
//  me-time
//
//  Created by junehee on 9/14/24.
//

import SwiftUI

struct OnboardingView: View {
    
    // @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Binding var isUser: Bool
    
    var body: some View {
        ZStack {
            LaunchScreenView()
            VStack {
                Spacer()
                CommonButton(title: "Start")
                    .wrapToButton { 
                        UserDefaultsManager.deleteAll()
                        UserDefaultsManager.userID = UUID().uuidString
                        UserDefaultsManager.nick = String(UserDefaultsManager.userID.split(separator: "-")[1])
                        UserDefaultsManager.isUser = true
                        
                        print("온보딩 - ID", UserDefaultsManager.userID)
                        print("온보딩 - nick", UserDefaultsManager.nick)
                        
                        isUser = true
                    }
                    .padding(.bottom, 10)
            }
        }
    }
    
}

#Preview {
    OnboardingView(isUser: .constant(false))
}
