//
//  FeedCellView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import SwiftUI
import Kingfisher

struct FeedCellView: View {
    @State var viewModel: FeedCellViewModel
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HStack {
                        NavigationLink {
                            if let user = viewModel.post.user {
                                ProfileView(viewModel: ProfileViewModel(user: user))
                            }
                        } label: {
                            KFImage(URL(string: viewModel.post.user?.profileImageUrl ?? ""))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color(red: 191/255, green: 11/255, blue: 180/255), lineWidth: 2)
                                }
                            
                            Text("\(viewModel.post.user?.username ?? "")")
                                .foregroundStyle(.white)
                                .bold()
                        }
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    .padding(8)
            }
            
            HStack {
                Image(systemName: "heart")
                
                Image(systemName: "bubble.right")
                
                Image(systemName: "paperplane")
                Spacer()
                
                Image(systemName: "bookmark")
            }
            .imageScale(.large)
            .padding(.horizontal, 10)
            
            Text("좋아요 \(viewModel.post.like)개")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("\(viewModel.post.user?.username ?? ""), \(viewModel.post.caption)")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("댓글 n개 더보기")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .padding(.bottom)
    }
}

// 그냥 주석처리 해도 됨
#Preview {
    FeedCellView(post: Post(id: "0Y6L3tsEh2obDf5TXLhe", userId: "GXnMezUMo3NNtI953HRkUyNRcGt1", caption: "내용", like: 0, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-9393f.appspot.com/o/images%2FB5DBCEB4-8E3C-4514-8AE9-12D47CF88CEE?alt=media&token=e3372992-c55f-4eed-9ba5-3d0e21ef1e58", date: Date()))
}
