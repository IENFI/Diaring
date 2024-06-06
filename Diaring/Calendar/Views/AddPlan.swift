//
//  AddPlan.swift
//  Diaring
//
//  Created by 하민영 on 5/16/24.
//

import SwiftUI

struct AddPlan: View {
    @EnvironmentObject var planModel: PlanViewModel
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    
    @State private var details: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    init(date: Date = Date()) {
        self._date = State(initialValue: date)
    }
    
    var body: some View {
        //        Text("Selected Date: \(planModel.isClickedDate, formatter: dateFormatter)")
        NavigationView {
            Form {
                Section(header: Text("일정 제목")) {
                    TextField("제목을 입력하세요", text: $title)
                }
                
                Section(header: Text("날짜 선택")) {
                    DatePicker("날짜를 선택하세요", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("일정 내용")) {
                    TextEditor(text: $details)
                        .frame(height: 200)
                }
                
            }
            .navigationBarTitle("새 일정 추가", displayMode: .inline)
            .navigationBarItems(trailing: Button("저장") {
                planModel.addPlan(title: title, date: date, details: details)
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                // View가 나타날 때 planModel.isClickedDate 값을 사용하여 date를 설정
                self.date = planModel.isClickedDate
            }
        }
        
        Spacer()
    }
}


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()


#Preview {
    NavigationView{
        AddPlan()
    }
    .environmentObject(PlanViewModel())
}
