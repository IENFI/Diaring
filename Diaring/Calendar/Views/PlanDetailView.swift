//
//  PlanDetailView.swift
//  Diaring
//
//  Created by 하민영 on 6/4/24.
//

import SwiftUI

struct PlanDetailView: View {
    @EnvironmentObject var planModel: PlanViewModel
    @State private var title: String
    @State private var details: String
    @State private var date: Date
    @State private var showAlert = false
    var plan: PlanModel

    init(plan: PlanModel) {
        self.plan = plan
        _title = State(initialValue: plan.title)
        _details = State(initialValue: plan.details)
        _date = State(initialValue: plan.date)
    }
    
    var body: some View {
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
        .navigationBarTitle("일정 수정", displayMode: .inline)
        .navigationBarItems(trailing: Button("수정") {
            let updatedPlan = PlanModel(id: plan.id, title: title, details: details, date: date)
            planModel.updatePlan(plan: updatedPlan)
            showAlert = true
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("수정 완료"),
                message: Text("일정이 성공적으로 수정되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}

struct PlanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePlan = PlanModel(title: "Sample Plan", details: "Sample Details", date: Date())
        return NavigationView {
            PlanDetailView(plan: samplePlan)
                .environmentObject(PlanViewModel())
        }
    }
}
