//
//  SignupBackgroundView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import SwiftUI

struct SignupBackgroundView<Content: View>: View {
    @Environment(\.dismiss) var dismiss // 현재의 뷰를 닫는 기능을 제공
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            content // 매개값으로 받은 뷰들
        }
        .navigationBarBackButtonHidden() // 기본으로 제공되는 뒤로가기 버튼 사용 안함
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}
