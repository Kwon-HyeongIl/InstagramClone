//
//  Comment.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    let commentText: String
    
    let postId: String
    let postUserId: String
    
    let commentUserId: String
    var commentUser: User?
    
    let date: Date
}

// 더미 데이터
extension Comment {
    static var DUMMY_COMMENT: Comment = Comment(id: UUID().uuidString, commentText: "dummy comment", postId: UUID().uuidString, postUserId: UUID().uuidString, commentUserId: UUID().uuidString, date: Date())
}
