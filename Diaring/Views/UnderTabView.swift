//
//  TabView.swift
//  Diaring
//
//  Created by 하민영 on 5/10/24.
//

import SwiftUI

struct UnderTabView: View {
    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }
            Text("")
        }
    }
}

#Preview {
    UnderTabView()
}
