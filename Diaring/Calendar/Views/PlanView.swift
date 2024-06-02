//
//  CalendarView.swift
//  Diaring
//
//  Created by 하민영 on 5/16/24.
//

import SwiftUI

//struct PlanView: View {
//    var selectedDate: Date
//    
//    var body: some View {
//        ZStack{
//            CalendarView()
//                .padding()
//        }
//            .navigationTitle("Plan")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading){
//                    EditButton()
//                }
//                ToolbarItem(placement: .navigationBarTrailing){
//                    NavigationLink {
//                        AddPlan()
//                    } label : {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//    }
//}

struct PlanView: View {
    var selectedDate: Date

    var body: some View {
            Text("Plan for \(formattedDate(selectedDate))")
                .navigationTitle("Plan")
        }

        private func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
}

#Preview {
    NavigationView{
        PlanView(selectedDate: Date())
    }
}
