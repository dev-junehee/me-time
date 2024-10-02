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
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            // LinearGradient(
            //     gradient: Gradient(stops: [
            //         .init(color: Color("primarySand").opacity(1), location: 0.0),
            //         .init(color: Color("primaryGreen"), location: 0.7)
            //     ]),
            //     startPoint: .top,
            //     endPoint: .bottom
            // )
            // .ignoresSafeArea()
            
            Image("launchScreen")
                .aspectRatio(contentMode: .fit)
        }
        // .aspectRatio(.infinity, contentMode: .fill)
    }
}

#Preview {
    LaunchScreenView()
}
