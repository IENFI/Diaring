//
//  AddView.swift
//  Diaring
//
//  Created by 하민영 on 4/15/24.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var vm: ListViewModel
    @Environment(\.dismiss) var dismiss // 화면을 닫는 역할
    
    @State var textFieldText: String = ""
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("할 일 추가", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("저장")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue).clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .font(.title2)
            .padding()
        }
        .navigationTitle("To do🖋️")
        .alert("내용이 짧아요", isPresented: $showAlert) {
            
        } message: {
            Text("내용이 있어야해요🥹")
        }
    }
    
    func saveButtonPressed() {
        if isAppropriate() {
            vm.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func isAppropriate() -> Bool {
        if textFieldText.count < 1 {
            showAlert.toggle()
            return false
        }
        return true
    }
}

#Preview {
    NavigationView{
        AddView()
    }
    .environmentObject(ListViewModel())
}
