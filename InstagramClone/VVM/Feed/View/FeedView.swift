//
//  FeedView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                    Spacer()
                            
                    Image(systemName: "heart")
                        .imageScale(.large)

                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                        
                ScrollView { // 값을 일부만 가져오고 스크롤 할 때마다 조금씩 값을 더 가져옴 (List 방법도 있지만 List의 기본 디자인 처리가 번거로워서 LazyVStack이 더 나은 선택지)
                    LazyVStack {
                        ForEach(viewModel.posts) { post in
                            FeedCellView(post: post)
                        }
                    }
                }
            }
            .refreshable { // 당겨서 새로고침 (이 함수 자체로 동시성 함수라서 동시성 처리는 안해도 됨)
                await viewModel.loadAllPosts()
            }
            .task { // 자동으로 바로 새로고침 (글을 포스팅 하고 피드 창으로 넘어올때마다 이 메서드가 호출)
                await viewModel.loadAllPosts()
        }
        }
    }
}

#Preview {
    FeedView()
}
