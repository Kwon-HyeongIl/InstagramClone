//
//  AuthManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import Foundation
import FirebaseAuth

@Observable
class AuthManager {
    
    static let shared = AuthManager() // 싱글톤은 shared로 이름 짓는게 관습
    
    var currentUserSession: FirebaseAuth.User? // 뷰에서 값의 변화를 감지해서 뷰를 자동으로 변경하기 위해 따로 Auth.auth().currentUser를 담은 변수 생성
    
    // 앱을 껐다가 켜도 로그인 상태로 남아있음 (앱을 다시 켤때마다 AuthManger 클래스가 새로 생성되므로, 이 초기화가 없으면 매번 currentUserSession 변수의 기본값인 nil이 자동으로 들어가므로 로그아웃 됨)
    init() {
        currentUserSession = Auth.auth().currentUser /// 서버와 동일한 메서드로 통신하는건데, 어떻게 사용자마다 다른 유저를 가져오지???
    }
    
    func createUser(email: String, password: String, name: String, username: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentUserSession = result.user
        } catch {
            print("failed to create user, \(error.localizedDescription)")
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut() // Firebase Auth 로그아웃 (currentUser를 nil로 만들어줌)
            currentUserSession = nil
        } catch {
            print("Failed to signout, \(error.localizedDescription )")
        }
    }
}
