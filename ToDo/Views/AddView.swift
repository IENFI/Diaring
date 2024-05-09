//
//  AddView.swift
//  ToDo
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
                TextField("메모를 추가할까요?", text: $textFieldText)
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
        .navigationTitle("메모 추가🖋️")
        .alert("메모가 짧아요", isPresented: $showAlert) {
            
        } message: {
            Text("메모를 조금 더 길게 써볼까요🥹")
        }
    }
    
    func saveButtonPressed() {
        if isAppropriate() {
            vm.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func isAppropriate() -> Bool {
        if textFieldText.count < 2 {
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
