//
//  LaunchScreenView.swift
//  me-time
//
//  Created by junehee on 9/14/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image("gradientBackground")
                .ignoresSafeArea()
            // LinearGradient(
            //     gradient: Gradient(stops: [
            //         .init(color: Color("primarySand").opacity(0), location: 0.0),
            //         .init(color: Color("primaryGreen"), location: 0.7)
            //     ]),
            //     startPoint: .top,
            //     endPoint: .bottom
            // )
            // .ignoresSafeArea()
            Image("launchScreen")
        }
    }
}

#Preview {
    LaunchScreenView()
}
