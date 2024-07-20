//
//  UserCountManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation
import Firebase

class UserCountManager {
    static func loadUserCountInfo(userId: String?) async -> UserCountInfo? {
        guard let userId else { return nil }
        
        do {
            async let followingDocuments = try await Firestore.firestore()
                .collection("following").document(userId)
                .collection("user-following").getDocuments()
            let followingCount = try await followingDocuments.count
            
            async let followerDocuments = try await Firestore.firestore()
                .collection("follower").document(userId)
                .collection("user-follower").getDocuments()
            let followerCount = try await followerDocuments.count
            
            async let postDocuments = try await Firestore.firestore()
                .collection("posts").whereField("userId", isEqualTo: userId).getDocuments()
            let postCount = try await postDocuments.count
            
            return UserCountInfo(postCount: postCount, followingCount: followingCount, followerCount: followerCount)
            
        } catch {
            print("Failed to load user count, \(error.localizedDescription)")
            return nil
        }
    }
}

struct UserCountInfo: Codable {
    var postCount: Int
    var followingCount: Int
    var followerCount: Int
}
