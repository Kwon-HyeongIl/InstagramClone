//
//  ProfileViewModel+Follow.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

extension ProfileViewModel {
    func follow() {
        Task {
            await AuthManager.shared.follow(userId: user?.id)
            user?.isFollowing = true
            
            await loadUserCountInfo()
        }
    }
    
    func unFollow() {
        Task {
            await AuthManager.shared.unFollow(userId: user?.id)
            user?.isFollowing = false
            
            await loadUserCountInfo()
        }
    }
    
    // 뷰 모델 생성시 사용
    func isFollow() async {
        
        self.user?.isFollowing = await AuthManager.shared.isFollow(userId: user?.id) // 확장에서 기존의 저장 프로퍼티에 접근 가능
        
    }
}
