//
//  SignupViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import Foundation
import FirebaseAuth

@Observable
class SignupViewModel {
    var email = ""
    var password = ""
    var name = ""
    var username = ""
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, name: name, username: username)
        
        // 로그인 후 다시 회원가입 창에 들어갔을때 남아있는 이전 입력 값들 삭제
        email = ""
        password = ""
        name = ""
        username = ""
    }
}
