//
//  ContentView.swift
//  ToDo
//
//  Created by 하민영 on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ToDoDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(ToDoDocument()))
}
