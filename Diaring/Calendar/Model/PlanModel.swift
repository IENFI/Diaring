//
//  PlanModel.swift
//  Diaring
//
//  Created by 하민영 on 6/3/24.
//

import SwiftUI

struct PlanModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var details: String
    
    init(id: UUID = UUID(), title: String, details: String, date: Date) {
            self.id = id
            self.title = title
            self.details = details
            self.date = date
        }
}
