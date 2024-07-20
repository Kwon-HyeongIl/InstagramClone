//
//  PostManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation
import FirebaseFirestore

class PostManager {
    static func loadAllPosts() async -> [Post]? {
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
            let posts = try documents.compactMap({ document in // compactMap은 nil 원소는 패스함
                return try document.data(as: Post.self)
            })
            return posts
            
        } catch {
            print("Failed to load User posts, \(error.localizedDescription)")
            return nil
        }
    }
    
    static func loadUserPosts(userId: String) async -> [Post]? {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: userId).getDocuments().documents
            
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self) // 리턴으로 받은 QueryDocumentSnapshot 타입의 값을 Post 타입의 값으로 변경
                posts.append(post)
            }
            return posts
            
        } catch {
            print("Failed to load User posts, \(error.localizedDescription)")
            return nil
        }
    }
}
