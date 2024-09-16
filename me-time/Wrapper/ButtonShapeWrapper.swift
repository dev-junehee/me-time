//
//  ButtonShapeWrapper.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

private struct ButtonShapeWrapper: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .clipShape(.buttonBorder)
        } else {
            content
                .cornerRadius(8)
        }
    }
}

extension View {
    func asButtonShape() -> some View {
        modifier(ButtonShapeWrapper())
    }
}
