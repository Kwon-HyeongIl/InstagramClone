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
    @State var isCommentShowing = false // true일 경우 댓글창이 위로 올라옴
    
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
                let isLike = viewModel.post.isLike ?? false
                Button {
                    Task {
                        isLike ? await viewModel.unlike() : await viewModel.like()
                    }
                } label: {
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .foregroundStyle(isLike ? .red : .primary)
                }
                
                Button {
                    isCommentShowing = true
                } label: {
                    Image(systemName: "bubble.right")
                }
                
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
            
            Button {
                isCommentShowing = true
            } label: {
                Text("댓글 \(viewModel.commentCount)개 더보기")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
            }
            
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .padding(.bottom)
        .sheet(isPresented: $isCommentShowing, content: { // 화면 밑에서 올라오는 뷰 (isCommentShowing 값은, 뷰를 내리면 이 함수가 자동으로 false로 바꾸므로 바인딩 기호 '$'를 써야함)
            CommentView(post: viewModel.post)
                .presentationDragIndicator(.visible)
        })
        .onChange(of: isCommentShowing) { oldValue, newValue in // 댓글 추가하고 댓글 개수 새로고침 하기 위한 과정
            if !newValue {
                Task {
                    await viewModel.loadCommentCount()
                }
            }
        }
    }
}

// 그냥 주석처리 해도 됨
#Preview {
    FeedCellView(post: Post(id: "0Y6L3tsEh2obDf5TXLhe", userId: "GXnMezUMo3NNtI953HRkUyNRcGt1", caption: "내용", like: 0, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-9393f.appspot.com/o/images%2FB5DBCEB4-8E3C-4514-8AE9-12D47CF88CEE?alt=media&token=e3372992-c55f-4eed-9ba5-3d0e21ef1e58", date: Date()))
}
