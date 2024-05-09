//
//  CustomTabView.swift
//  Diaring
//
//  Created by 하민영 on 4/11/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case plan = "calendar"
    case todo = "checklist"
    case setting = "person.circle.fill"
    
    var titleText: String {
        switch self {
        case .plan:
            return "일정"
        case .todo:
            return "할 일"
        case .setting:
            return "설정"
        }
    }
}

struct CustomTabView: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        
        HStack(spacing:0){
            ForEach(Tab.allCases, id: \.rawValue){ tab in
                Button{
                    withAnimation(.spring()) {
                        currentTab = tab
                    }
                } label: {
                    VStack(spacing: 1){
                        Image(systemName: tab.rawValue)
                            .font(.subheadline).bold()
                            .scaleEffect(currentTab == tab ? 1.1 : 0.9)
                            .frame(maxWidth: .infinity)
                            .background{
                                Capsule()
                                    .fill(currentTab == tab ? .green : .clear)
                                    .frame(width: currentTab == tab ? 60 : 0)
                                    .frame(height: 2)
                                    .offset(y: -17)
                            }
                        Text(tab.titleText)
                            .font(.caption)
                    }
                    .foregroundColor(currentTab == tab ? .green : .gray)
                }
                .buttonStyle(TabButtonStyle())
            }
        }
        .frame(height: 30)
        .padding(.top, 10)
        .padding(.bottom, 8)
        .background(.ultraThinMaterial)
    }
}

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    CustomTabView(currentTab: .constant(Tab.plan))
}
