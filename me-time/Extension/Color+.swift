//
//  Color+.swift
//  me-time
//
//  Created by junehee on 9/18/24.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        let taupeGray = Color(red: 180, green: 180, blue: 184)
        let blueGray = Color(red: 199, green: 200, blue: 204)
        let beigeGray = Color(red: 227, green: 225, blue: 217)
        let yellowGray = Color(red: 242, green: 239, blue: 229)
        return [taupeGray, blueGray, beigeGray, yellowGray].randomElement()!
    }
}
