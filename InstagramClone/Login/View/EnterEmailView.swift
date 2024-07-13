//
//  EnterEmailView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import SwiftUI

struct EnterEmailView: View {
    var body: some View {
        SignupBackgroundView {
            // VStack(alignment: .leading)로 이 스택 내에 있는 모든 뷰를 왼쪽 정렬 가능
            VStack {
                Text("이메일 주소 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("이메일 주소", text: .constant(""))
                    .modifier(InstagramTextFieldModifier())
                    .padding(.bottom)
                
                NavigationLink {
                    EnterPasswordView()
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
        }
        
    }
}

#Preview {
    EnterEmailView()
}
