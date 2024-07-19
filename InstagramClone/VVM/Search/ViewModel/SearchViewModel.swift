//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import Foundation

@Observable
class SearchViewModel {
    var users: [User] = []
    
    init() {
        Task {
            await loadAllUserData()
        }
    }
    
    func loadAllUserData() async {
        self.users = await AuthManager.shared.loadAllUserData() ?? []
    }
}
