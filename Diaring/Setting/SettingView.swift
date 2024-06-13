//
//  SettingView.swift
//  Diaring
//
//  Created by 하민영 on 6/14/24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var darkModeSettings = DarkModeSettingsViewModel()
    
    var body: some View {
        VStack {
            Toggle(isOn: $darkModeSettings.isDarkModeOn) {
                Text("다크 모드")
                    .font(.headline)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("설정")
        .preferredColorScheme(darkModeSettings.isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    SettingView()
}
