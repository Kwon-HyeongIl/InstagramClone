//
//  ProfileView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel = ProfileViewModel()
    
    /*
     <GridItem>
     .fixed: 열 개수 및 크기 고정
     .flexible: 열 개수 고정, 크기는 자동
     .adaptive: 열 개수 자동, 크기도 자동
     */
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("\(viewModel.username)")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                            
                        } else if let imageUrl = viewModel.user?.profileImageUrl {
                            let url = URL(string: imageUrl)
                            
                            KFImage(url)
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
                        
                        VStack {
                            Text("\(viewModel.postCount ?? 0)")
                                .fontWeight(.semibold)
                            Text("게시물")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("\(viewModel.followerCount ?? 0)")
                                .fontWeight(.semibold)
                            Text("팔로워")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("\(viewModel.followingCount ?? 0)")
                                .fontWeight(.semibold)
                            Text("팔로잉")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    
                    Text("\(viewModel.name)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text("\(viewModel.bio)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    if viewModel.user?.isCurrentUser == true {
                        NavigationLink {
                            ProfileEditingView(viewModel: viewModel)
                        } label: {
                            Text("프로필 편집")
                                .bold()
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    } else {
                        let isFollowing = viewModel.user?.isFollowing ?? false
                        Button {
                            if isFollowing {
                                viewModel.unFollow()
                            } else {
                                viewModel.follow()
                            }
                        } label: {
                            Text(isFollowing ? "팔로잉" : "팔로우")
                                .bold()
                                .foregroundStyle(isFollowing ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(isFollowing ? .gray.opacity(0.4) : .blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                    Divider()
                        .padding()
                    
                    // LazyVGrid는 스크롤 할 때, 그제서야 메모리에 적재
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(viewModel.posts) { post in
                            let url = URL(string: post.imageUrl)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/) // 직사각형 사진들도 정사각형으로 나옴
                        }
                    }
                    .task {
                        await viewModel.loadUserPosts()
                    }
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.loadUserCountInfo()
        }
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
    ProfileView()
}
