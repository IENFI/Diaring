//
//  TabView2.swift
//  Diaring
//
//  Created by 하민영 on 4/11/24.
//

import SwiftUI

struct UnderTab: View {
    @State var currentTab: Tab = .plan
    @EnvironmentObject var vm: ListViewModel
    
    init() { // Tab View가 사라져도 터치가 되는 현상 수정. 이 뷰가 init될 때 Tab View가 보이지 않게끔 구성한다.
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        HStack{
            ZStack(alignment: .bottom) {
                TabView(selection : $currentTab){
                    NavigationView {
                        CalendarView()
                        //                        .padding()
                    }
                    .tag(Tab.plan)
                    .padding(.bottom, 50)
                    NavigationView {
                        ListView()
                    }
                    .tag(Tab.todo)
                    .padding(.bottom, 50)
                    NavigationView {
                        SettingView()
                    }
                    .tag(Tab.setting)
                    .padding(.bottom, 50)
                }
                
                CustomTabView(currentTab: $currentTab)
                
            }
            
        }
        .listStyle(.plain)
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarLeading){
        //                EditButton()
        //            }
        //            ToolbarItem(placement: .navigationBarTrailing){
        //                NavigationLink {
        //                    AddView()
        //                } label : {
        //                    Image(systemName: "plus")
        //                }
        //            }
        //        }
    }
}

#Preview {
    NavigationView {
        UnderTab()
    }
    .environmentObject(ListViewModel())
}
