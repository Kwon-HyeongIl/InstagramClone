//
//  FeedCellViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import Foundation

@Observable
class FeedCellViewModel {
    var post: Post
    
    init(post: Post) {
        self.post = post
        Task {
            await loadUserData()
        }
    }
    
    // 뷰에서 AuthManager에 있는 메서드에 바로 접근하는게 아니라, 항상 뷰 모델을 거쳐서 접근함
    func loadUserData() async {
        guard let user = await AuthManager.shared.loadUserData(userId: post.userId) else { return }
        post.user = user
    }
}
