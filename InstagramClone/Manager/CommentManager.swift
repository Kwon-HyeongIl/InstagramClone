//
//  CommentManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation
import Firebase

class CommentManager {
    static func uploadComment(comment: Comment, postId: String) async {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        do {
            try await Firestore.firestore()
                .collection("posts").document(postId)
                .collection("post-comment").addDocument(data: commentData)
        } catch {
            print("Failed to upload comment, \(error.localizedDescription)")
        }
    }
    
    static func loadComment(postId: String) async -> [Comment] {
        do {
            let documents = try await Firestore.firestore()
                .collection("posts").document(postId)
                .collection("post-comment").order(by: "date", descending: true).getDocuments().documents
            
            let comments = documents.compactMap { document in
                try? document.data(as: Comment.self)
            }
            
            return comments
            
        } catch {
            print("Failed to load comment, \(error.localizedDescription)")
            return []
        }
    }
    
    static func loadCommentCount(postId: String) async -> Int {
        do {
            let documents = try await Firestore.firestore()
                .collection("posts").document(postId)
                .collection("post-comment").getDocuments().documents
        
            return documents.count
            
        } catch {
            print("Failed to load comment count, \(error.localizedDescription)")
            return 0
        }
    }
}
