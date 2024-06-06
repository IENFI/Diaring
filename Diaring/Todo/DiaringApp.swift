//
//  DiaringApp.swift
//  Diaring
//
//  Created by 하민영 on 3/29/24.
//

import SwiftUI

@main
struct DiaringApp: App {
    @StateObject var vm = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                UnderTab()
            }
            .environmentObject(vm)
            .environmentObject(vm)
        }
    }
}

