//
//  ProfileEditingView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/15/24.
//

import SwiftUI
import PhotosUI
import Kingfisher // 이미지 캐싱 외부 라이브러리

struct ProfileEditingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.selectedItem) {
                VStack {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                        
                    } else if let imageUrl = viewModel.user?.profileImageUrl {
                        let url = URL(string: imageUrl)
                        
                        KFImage(url) // 이미지가 캐싱 됨
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(.bottom, 10)

                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundStyle(Color(.systemGray3))
                            .clipShape(Circle())
                            .padding(.bottom, 10)
                    }
                    
                    Text("프로필 이미지 수정")
                        .foregroundStyle(.blue)
                }
            }
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("이름")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("이름", text: $viewModel.name)
                    .font(.title3)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("사용자 이름")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("사용자 이름", text: $viewModel.username)
                    .font(.title3)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("소개")
                    .foregroundStyle(.gray)
                    .bold()
                TextField("소개", text: $viewModel.bio)
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
                    Task {
                        await viewModel.updateUser()
                        dismiss() // 여기서 dismiss()가 Task 안에 있으면, 서버에 업데이트 하고 뒤로가기가 수행됨. dismiss()가 Task 밖에 있으면, 서버에 업데이트 하는 것과 동시에 뒤로가기 수행
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    ProfileEditingView(viewModel: ProfileViewModel())
}
