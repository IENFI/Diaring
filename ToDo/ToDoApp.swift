//
//  ToDoApp.swift
//  ToDo
//
//  Created by 하민영 on 4/15/24.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    @StateObject var vm = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(vm)
            .environmentObject(vm)
        }
    }
}
