//
//  LoginView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import SwiftUI

struct LoginView: View {
    
    
    
    // 255가 Max인 RGB 값을 분수로 넣어도 됨
//    Color(red: 249/255, green: 238/255, blue: 243/255)
    
    var body: some View {
        
        NavigationStack { // 페이지들을 단계별로 스택으로 다룸
            ZStack {
                GradientBackgroundView()
                
                VStack {
                    Spacer()
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    Spacer()
                    
                    VStack(spacing: 20) { // 이 스택 내에 있는 모든 뷰에 20만큼 공간을 줌
                        TextField("이메일 주소", text: .constant(""))
                            .modifier(InstagramTextFieldModifier())
                        
                        SecureField("비밀번호", text: .constant("")) // 비밀번호용 텍스트 필드
                            .modifier(InstagramTextFieldModifier())
                        
                        BlueButtonView {
                            
                        } label: {
                            Text("로그인")
                        }
                        
                        Text("비밀번호를 잊으셨나요?")
                    }
                    Spacer()
                    
                    NavigationLink {
                        EnterEmailView()
                    } label: {
                        Text("새 계정 만들기")
                            .fontWeight(.bold)
                            .frame(width: 363, height: 42)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.blue, lineWidth: 1.0)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
