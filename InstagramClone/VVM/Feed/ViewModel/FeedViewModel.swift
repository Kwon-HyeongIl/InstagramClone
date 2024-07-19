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
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).getDocuments().documents
            
            /*
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            self.posts = posts
            */
            
            // 위와 동일한 기능을 하는 코드
            self.posts = try documents.compactMap({ document in // compactMap은 nil 원소는 패스함
                return try document.data(as: Post.self)
            })
            
        } catch {
            print("Failed to load User posts, \(error.localizedDescription)")
        }
    }
}
