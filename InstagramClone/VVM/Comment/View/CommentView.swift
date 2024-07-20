//
//  CommentView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var commentText = ""
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            Text("댓글")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .padding(.top, 30)
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCellView(comment: comment)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
            }
            
            Divider()
            
            HStack {
                if let imageUrl = AuthManager.shared.currentUser?.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
                
                TextField("댓글 작성", text: $commentText, axis: .vertical) // axis로 .vertical로 설정할 경우, 화면을 초과해서 글이 입력 되었을 경우 수직으로 창이 늘어남
                
                Button {
                    Task {
                        await viewModel.uploadComment(commentText: commentText)
                        commentText = "" // 댓글 작성하고 나서 댓글 입력창 초기화
                    }
                } label: {
                    Text("보내기")
                }
            }
            .padding()
        }
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
