//
//  EnvironmentValues+.swift
//  me-time
//
//  Created by junehee on 10/2/24.
//

import SwiftUI

private struct TabBarHiddenKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

private struct DeepLinkEnv: EnvironmentKey {
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    var isTabBarHidden: Binding<Bool> {
        get { self[TabBarHiddenKey.self] }
        set { self[TabBarHiddenKey.self] = newValue }
    }
    
    var deepLinkText: String {
        get { self[DeepLinkEnv.self] }
        set { self[DeepLinkEnv.self] = newValue }
    }
}
