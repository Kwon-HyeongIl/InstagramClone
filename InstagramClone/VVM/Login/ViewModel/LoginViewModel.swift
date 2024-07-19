//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func login() async {
        await AuthManager.shared.login(email: email, password: password)
    }
}
