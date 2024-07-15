//
//  ProfileView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import SwiftUI

struct ProfileView: View {
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
                    Text("티바견")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .opacity(0.6)
                            .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("124")
                                .fontWeight(.semibold)
                            Text("게시물")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("100")
                                .fontWeight(.semibold)
                            Text("팔로워")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("100")
                                .fontWeight(.semibold)
                            Text("팔로잉")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    
                    Text("이름")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text("소개")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    NavigationLink {
                        ProfileEditingView()
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
                    
                    Divider()
                        .padding()
                    
                    // LazyVGrid는 스크롤 할 때, 그제서야 메모리에 적재
                    LazyVGrid(columns: columns, spacing: 2) {
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
