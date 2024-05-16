//
//  TabView2.swift
//  Diaring
//
//  Created by 하민영 on 4/11/24.
//

import SwiftUI

struct TabView2: View {
    @State var currentTab: Tab = .plan
    
    init() { // Tab View가 사라져도 터치가 되는 현상 수정. 이 뷰가 init될 때 Tab View가 보이지 않게끔 구성한다.
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection : $currentTab){
                ListView()
                    .tag(Tab.plan)
                ListView()
                    .tag(Tab.todo)
                Text("설정")
                    .tag(Tab.setting)
            }
            
            CustomTabView(currentTab: $currentTab)
        }
        .listStyle(.plain)
        .navigationTitle("할 일")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink {
                    AddView()
                } label : {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        TabView2()
    }
    .environmentObject(ListViewModel())
}
