//
//  EditPlanView.swift
//  Diaring
//
//  Created by 하민영 on 5/10/24.
//

import SwiftUI

struct EditPlanView: View {
    @EnvironmentObject var vm: ListViewModel
    @Environment(\.dismiss) var dismiss // 화면을 닫는 역할
    
    @State var textFieldText: String = ""
    
    @State var showAlert: Bool = false
    
    @State private var selectedDate = Date()
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("일정 제목", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()
                

                DatePicker("Select a date and time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .frame(alignment: .center)
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("수정")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue).clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
            }
            .font(.title2)
            .padding()
            
        }
        .navigationTitle("일정 수정🖋️")
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
    
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            return formatter
        }
}

#Preview {
    
    NavigationView{
        EditPlanView()
    }
    .environmentObject(ListViewModel())
}
