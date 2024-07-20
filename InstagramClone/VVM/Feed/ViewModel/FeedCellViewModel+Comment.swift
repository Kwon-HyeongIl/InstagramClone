//
//  FeedCellViewModel+Comment.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

extension FeedCellViewModel {
    func loadCommentCount() async {
        self.commentCount = await CommentManager.loadCommentCount(postId: self.post.id)
    }
}
