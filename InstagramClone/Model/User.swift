//
//  User.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import Foundation
import FirebaseAuth

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
    var isFollowing: Bool?
    var userCountInfo: UserCountInfo?
    
    // 다른 사람 프로필에 들어갈 경우 사용
    var isCurrentUser: Bool {
        guard let currentUserId = AuthManager.shared.currentUser?.id else { return false }
        return id == currentUserId
    }
}

// 더미 데이터
extension User {
    static var DUMMY_USER: User = User(id: UUID().uuidString, email: "dummy@naver.com", username: "dummyUsername", name: "dummy")
}
