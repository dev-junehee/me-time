//
//  OnboardingView.swift
//  me-time
//
//  Created by junehee on 9/14/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var isLaunching = true
    
    var body: some View {
        if isLaunching {
            LaunchScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLaunching = false
                    }
                }
        } else {
            NavigationView {
                ZStack {
                    LaunchScreenView()
                    VStack {
                        Spacer()
                        NavigationLink {
                            
                        } label: {
                            CommonButton(title: "Done")
                        }

                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
