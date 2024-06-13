//
//  CalendarPicker.swift
//  Diaring
//
//  Created by 하민영 on 5/16/24.
//

import SwiftUI

struct CalendarPicker: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)

            NavigationLink(destination: PlanView(selectedDate: selectedDate)) {
                Text("Go to Plan")
            }
        }
    }
}

#Preview {
    NavigationView {
        CalendarPicker()
    }
}
