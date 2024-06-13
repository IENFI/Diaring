//
//  ListView.swift
//  Diaring
//
//  Created by 하민영 on 4/15/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var vm: ListViewModel
    @StateObject var darkModeSettings = DarkModeSettingsViewModel()
    
    var body: some View {
        
        ZStack {
            if vm.items.isEmpty {
                NoItemsView()
            } else {
                List{
                    ForEach(vm.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    vm.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: vm.deleteItem)
                    .onMove(perform: vm.moveItem)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("할 일")
//        .navigationBarTitle("To do", displayMode : .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
                    .font(.title)
                    .foregroundColor(darkModeSettings.isDarkModeOn ? .white : .black)
            }
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink {
                    AddView()
                } label : {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(darkModeSettings.isDarkModeOn ? .white : .black)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
