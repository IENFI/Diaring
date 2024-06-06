//
//  PlanListView.swift
//  Diaring
//
//  Created by 하민영 on 6/4/24.
//

import SwiftUI

struct PlanListView: View {
    @EnvironmentObject var planModel: PlanViewModel
    var date: Date
    
    var body: some View {
        List {
            ForEach(planModel.plans.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }) { plan in
                NavigationLink(destination: PlanDetailView(plan: plan).environmentObject(planModel)) {
                    PlanListRowView(plan: plan)
                }
            }
            .onDelete(perform: planModel.deletePlan)
        }
        .navigationBarTitle("일정 목록")
    }
}


#Preview {
    PlanListView(date: Date())
        .environmentObject(PlanViewModel())
}
