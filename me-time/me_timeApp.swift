//
//  me_timeApp.swift
//  me-time
//
//  Created by junehee on 9/11/24.
//

import SwiftUI

@main
struct me_timeApp: App {
    @State var isUser = false
    @State var isSplashView = true
    
    var body: some Scene {
        WindowGroup {
            if isUser {
                CustomTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
