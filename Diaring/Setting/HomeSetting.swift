//
//  HomeSetting.swift
//  Diaring
//
//  Created by 하민영 on 5/10/24.
//

import SwiftUI

struct HomeSetting: View {
    let selection = ["Todo", "Plan"]
        @State private var selectedFunction = "Plan"
        
        var body: some View {
            VStack {
                Picker("Select Main Function", selection: $selectedFunction) {
                    ForEach(selection, id: \.self) {
                        Text($0)
                    }
                }
                Text("You selected Main: \(selectedFunction)")
                
                
                Button(action: {}, label: {
                    Text("설정 완료")
                        .foregroundStyle(.white)
                })
                .frame(width:100, height: 30)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
            .padding(.horizontal)
            .frame(maxHeight: 300)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .padding()
        }
//    
//    var body: some View {
//        VStack{
//            Button(<#T##title: StringProtocol##StringProtocol#>, action: <#T##() -> Void#>)
//            Text("등록")
//        }
//    }
}

#Preview {
    HomeSetting()
}
