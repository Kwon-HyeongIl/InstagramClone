//
//  ProfileEditingView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/15/24.
//

import SwiftUI

struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("image_dog")
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .padding(.bottom, 10)
            Text("프로필 이미지 수정")
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("이름")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("이름", text: .constant(""))
                    .font(.title3)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("사용자 이름")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("사용자 이름", text: .constant(""))
                    .font(.title3)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("소개")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("소개", text: .constant(""))
                    .font(.title3)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
        }
        .navigationTitle("프로필 편집")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    ProfileEditingView()
}
