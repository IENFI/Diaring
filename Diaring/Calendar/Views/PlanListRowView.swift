//
//  PlanListRowView.swift
//  Diaring
//
//  Created by 하민영 on 6/4/24.
//

import SwiftUI

struct PlanListRowView: View {
    let plan: PlanModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(plan.title)
                    .font(.headline)
                Text(plan.details)
                    .font(.subheadline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    PlanListRowView()
//}


struct PlanListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item1 = PlanModel(title: "Hello 11", details: "Hello", date: Date())
        let item2 = PlanModel(title: "Hello 33", details: "Hello", date: Date())
        
        return Group {
            PlanListRowView(plan: item1)
            PlanListRowView(plan: item2)
        }
        //        .previewLayout(.sizeThatFits)
    }
}
