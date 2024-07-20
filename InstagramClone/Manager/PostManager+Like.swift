//
//  PostManager+Like.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation
import FirebaseFirestore

extension PostManager {
    static func like(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("users")
        
        async let _ = usersCollection.document(userId).collection("user-like").document(post.id).setData([:])
        async let _ = postsCollection.document(post.id).collection("post-liked").document(userId).setData([:])
        async let _ = postsCollection.document(post.id).updateData(["like": post.like + 1])
    }
    
    static func unlike(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("users")
        
        async let _ = usersCollection.document(userId).collection("user-like").document(post.id).delete()
        async let _ = postsCollection.document(post.id).collection("post-liked").document(userId).delete()
        async let _ = postsCollection.document(post.id).updateData(["like": post.like - 1])
    }
    
    static func isLike(post: Post) async -> Bool {
        guard let userId = AuthManager.shared.currentUser?.id else { return false }
        
        do {
            let isLike = try await Firestore.firestore()
                .collection("users").document(userId)
                .collection("user-like").document(post.id)
                .getDocument().exists
            return isLike
        } catch {
            print("Failed to check like, \(error.localizedDescription)")
            return false
        }
    }
}
