//
//  NoItemsView.swift
//  ToDo
//
//  Created by 하민영 on 5/7/24.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("메모가 없어요")
                    .font(.largeTitle)
                Text("당신은 창의적인 사람인가요?\n해야할 일들을 자유롭게 작성해보세요.\n기록하지 않으면 잊혀지기 마련이에요.")
                    .font(.title3)
                    .padding(.bottom, 15)
                
                
                NavigationLink{
                    AddView()
                } label: {
                    Text("첫 번째 메모 추가하기")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.purple :  Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, animate ? 30 : 50)
                        .scaleEffect(animate ? 1.1 : 1.0)
                        .shadow(color: animate ? Color.purple.opacity(0.5) : Color.blue.opacity(0.7), radius: animate ? 10 : 30, x: 0, y: animate ? 10 : 0)
                        .shadow(color: animate ? Color.purple.opacity(0.5) : Color.blue.opacity(0.7), radius: animate ? 10 : 30, x: 0, y: animate ? 10 : 0)
                        .offset(y: animate ? -7 : 0)
                }
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .onAppear (perform: animateUI)
    }
    func animateUI() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeIn(duration: 1.6).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NoItemsView()
}
