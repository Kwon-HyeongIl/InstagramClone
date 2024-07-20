//
//  FeedCellViewModel+Like.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

extension FeedCellViewModel {
    func like() async {
        await PostManager.like(post: self.post)
        
        self.post.isLike = true
        self.post.like += 1
    }
    
    func unlike() async {
        await PostManager.unlike(post: self.post)
        
        self.post.isLike = false
        self.post.like -= 1
    }
    
    func isLike() async {
        self.post.isLike = await PostManager.isLike(post: self.post)
    }
}

