//
//  DarkModelSettingsViewModel.swift
//  Diaring
//
//  Created by 하민영 on 6/14/24.
//

import SwiftUI

class DarkModeSettingsViewModel: ObservableObject {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    var isDarkModeOn: Bool {
        get { isDarkModeEnabled }
        set { isDarkModeEnabled = newValue }
    }
}
