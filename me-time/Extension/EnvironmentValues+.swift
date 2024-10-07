//
//  EnvironmentValues+.swift
//  me-time
//
//  Created by junehee on 10/2/24.
//

import SwiftUI

private struct TabBarHiddenKey: EnvironmentKey {
    // static let defaultValue: Bool = false
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    // var isTabBarHidden: Bool {
    //     get { self[TabBarVisibilityKey.self] }
    //     set { self[TabBarVisibilityKey.self] = newValue }
    // }
    var isTabBarHidden: Binding<Bool> {
        get { self[TabBarHiddenKey.self] }
        set { self[TabBarHiddenKey.self] = newValue }
    }
}
