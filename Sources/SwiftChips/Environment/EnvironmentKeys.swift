//
//  EnvironmentKeys.swift
//  
//
//  Created by Andrea Ciani on 26.04.23.
//

import SwiftUI

struct AccentColorKey: EnvironmentKey {
    static let defaultValue: Color = .accentColor
}

extension EnvironmentValues {
    var accentColor: Color {
        get { self[AccentColorKey.self] }
        set { self[AccentColorKey.self] = newValue }
    }
}
