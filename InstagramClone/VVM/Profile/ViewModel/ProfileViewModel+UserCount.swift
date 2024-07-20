//
//  ProfileViewModel+UserCount.swift
//  InstagramClone
//
//  Created by 권형일 on 7/20/24.
//

import Foundation

extension ProfileViewModel {
    func loadUserCountInfo() async {
        self.user?.userCountInfo = await UserCountManager.loadUserCountInfo(userId: self.user?.id)
    }
}
