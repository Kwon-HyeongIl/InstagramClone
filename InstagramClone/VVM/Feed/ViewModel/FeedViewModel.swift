//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import Foundation
import Firebase

@Observable
class FeedViewModel {
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllPosts()
        }
    }
    
    func loadAllPosts() async {
        guard let posts = await PostManager.loadAllPosts() else { return }
        self.posts = posts
    }
}
