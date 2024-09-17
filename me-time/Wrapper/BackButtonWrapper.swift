//
//  BackButtonWrapper.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
            print("dismiss")
        } label: {
            Image(.backButton)
                // .renderingMode(.template)
                // .shadow(radius: 2.0)
                // .contentShape(Rectangle())
        }
    }
}

struct BackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
    }
}

public extension View {
    func asCustomBackButton() -> some View {
        modifier(BackButtonModifier())
    }
}

