//
//  CommonButton.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct CommonButton: View {
    let title: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .foregroundStyle(Color("primaryBlack"))
                .asButtonShape()
                .padding(.horizontal)
            Text(title)
                .baselineOffset(-8)
                .foregroundStyle(Color("primaryWhite"))
                .font(.morenaBold20)
        }
    }
}

#Preview {
    CommonButton(title: "Done")
}
