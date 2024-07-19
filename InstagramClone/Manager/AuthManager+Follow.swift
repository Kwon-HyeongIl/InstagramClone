//
//  AuthManager+follow.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation
import Firebase

extension AuthManager {
    func follow(userId: String?) async {
        guard let currentUserId = currentUser?.id else { return }
        guard let userId else { return }
        
        do {
            async let _ = try await Firestore.firestore() // async let으로 동시에 실행, 반환해서 쓸 값이 있을 경우 _ 대신 변수 기입
                .collection("following")
                .document(currentUserId)
                .collection("user-following")
                .document(userId)
                .setData([:])
            
            async let _ = try await Firestore.firestore()
                .collection("follower")
                .document(userId)
                .collection("user-follower")
                .document(currentUserId)
                .setData([:])
        } catch {
            print("Failed to following, \(error.localizedDescription)")
        }
    }
    
    func unFollow(userId: String?) async {
        guard let currentUserId = currentUser?.id else { return }
        guard let userId else { return }
        
        do {
            async let _ = try await Firestore.firestore() // async let으로 동시에 실행, 반환해서 쓸 값이 있을 경우 _ 대신 변수 기입
                .collection("following")
                .document(currentUserId)
                .collection("user-following")
                .document(userId)
                .delete()
            
            async let _ = try await Firestore.firestore()
                .collection("follower")
                .document(userId)
                .collection("user-follower")
                .document(currentUserId)
                .delete()
        } catch {
            print("Failed to unFollowing, \(error.localizedDescription)")
        }
    }
    
    func isFollow(userId: String?) async -> Bool {
        guard let currentUserId = currentUser?.id else { return false }
        guard let userId else { return false }
        
        do {
            return try await Firestore.firestore()
                .collection("following")
                .document(currentUserId)
                .collection("user-following")
                .document(userId)
                .getDocument()
                .exists
        } catch {
            return false
        }
    }
}
