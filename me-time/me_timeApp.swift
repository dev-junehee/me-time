//
//  me_timeApp.swift
//  me-time
//
//  Created by junehee on 9/11/24.
//

import SwiftUI

/**
- 런치스크린은 항상 뜨기
- isUser 값에 따라 첫 화면 핸들링 - Onboarding, Main
*/

@main
struct me_timeApp: App {
    
    @State var isLaunching = true
    @State var isUser = UserDefaultsManager.isUser
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.linear) { isLaunching = false }
                        }
                    }
            } else {
                if isUser {
                    ContentView()
                } else {
                    withAnimation(.linear) {
                        OnboardingView(isUser: $isUser)
                    }
                }
            }
        }
    }
}
