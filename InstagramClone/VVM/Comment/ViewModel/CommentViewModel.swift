//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

@Observable
class CommentViewModel {
    var comments: [Comment] = []
    var postId: String
    var postUserId: String
    
    init(post: Post) {
        self.postId = post.id
        self.postUserId = post.userId
        
        Task {
            await loadComment()
        }
    }
    
    func uploadComment(commentText: String) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let comment = Comment(id: UUID().uuidString, commentText: commentText, postId: postId, postUserId: postUserId, commentUserId: userId, date: Date())
        
        await CommentManager.uploadComment(comment: comment, postId: postId)
        await loadComment() // 댓글 작성 후 새로고침
    }
    
    func loadComment() async {
        self.comments = await CommentManager.loadComment(postId: postId)
        
        for i in 0..<comments.count {
            let user = await AuthManager.shared.loadUserData(userId: comments[i].commentUserId)
            comments[i].commentUser = user
        }
    }
}
