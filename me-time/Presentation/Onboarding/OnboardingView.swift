//
//  OnboardingView.swift
//  me-time
//
//  Created by junehee on 9/14/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var isLaunching = true
    
    @State private var navigationPath = NavigationPath()
    @State private var isPresented = false
    
    var body: some View {
        if isLaunching {
            LaunchScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.linear) {
                            isLaunching = false
                        }
                    }
                }
        } else {
            NavigationStack(path: $navigationPath) {
                ZStack {
                    LaunchScreenView()
                    VStack {
                        Spacer()
                        CommonButton(title: "Start")
                            .wrapToButton {
                                isPresented = true
                                if isPresented {
                                    // navigationPath = NavigationPath([CustomTabView()])
                                }
                            }
                            .padding(.bottom, 60)
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
