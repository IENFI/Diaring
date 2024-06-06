//
//  CalendarViewModel.swift
//  Diaring
//
//  Created by 하민영 on 6/3/24.
//

import SwiftUI

class PlanViewModel: ObservableObject {
    @Published var isClickedDate: Date = Date() // 기본값을 현재 날짜로 설정
    @Published var plans: [PlanModel] = []{
        didSet {
            savePlans()
        }
    }
    
    private let plansKey = "plans_list"
    
    init() {
        getPlans()
    }
    
    func Click(by date : Date) {
        isClickedDate = date
    }
    
    func addPlan(title: String, date: Date, details: String) {
        let newPlan = PlanModel(title: title, details: details, date: date)
        plans.append(newPlan)
    }
    
    func getItems(for date: Date) -> [PlanModel] {
        let calendar = Calendar.current
        return plans.filter { item in
            calendar.isDate(item.date, inSameDayAs: date)
        }
    }
    
    func getPlans() {
        guard
            let data = UserDefaults.standard.data(forKey: plansKey),
            let decodedData = try? JSONDecoder().decode([PlanModel].self, from: data)
        else { return }
        plans = decodedData
    }
    
    func plans(for date: Date) -> [PlanModel] {
        let calendar = Calendar.current
        return plans.filter { item in
            calendar.isDate(item.date, inSameDayAs: date)
        }
    }
    
    func updatePlan(plan: PlanModel) {
        if let index = plans.firstIndex(where: { $0.id == plan.id }) {
            plans[index] = plan
            savePlans()
        }
    }
    
    func deletePlan(indexSet: IndexSet) {
        plans.remove(atOffsets: indexSet)
    }
    
    private func savePlans() {
        if let encodedData = try? JSONEncoder().encode(plans) {
            UserDefaults.standard.set(encodedData, forKey: plansKey)
        }
    }
}
