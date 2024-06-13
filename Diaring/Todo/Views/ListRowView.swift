//
//  ListRowView.swift
//  Diaring
//
//  Created by 하민영 on 4/15/24.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .yellow)
            
            Text(item.title)

            Spacer()
        }
        .font(.title2)
//        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let item1 = ItemModel(title: "Hello 11", isCompleted: false)
        let item2 = ItemModel(title: "Hello 33", isCompleted: true)
        
        return Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
//        .previewLayout(.sizeThatFits)
    }
}
