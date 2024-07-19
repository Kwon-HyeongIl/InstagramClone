//
//  AuthManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/14/24.
//

import Foundation
import FirebaseAuth
import Firebase

@Observable
class AuthManager {
    
    static let shared = AuthManager() // 싱글톤은 shared로 이름 짓는게 관습
    
    var currentAuthUser: FirebaseAuth.User? // 뷰에서 값의 변화를 감지해서 뷰를 자동으로 변경하기 위해 따로 Auth.auth().currentUser를 담은 변수 생성
    var currentUser: User?
    
    // 앱을 껐다가 켜도 로그인 상태로 남아있음 (앱을 다시 켤때마다 AuthManger 클래스가 새로 생성되므로, 이 초기화가 없으면 매번 currentUserSession 변수의 기본값인 nil이 자동으로 들어가므로 로그아웃 됨)
    init() {
        currentAuthUser = Auth.auth().currentUser /// 서버와 동일한 메서드로 통신하는건데, 어떻게 사용자마다 다른 유저를 가져오지???
        Task {
            await loadCurrentUserData()
        }
    }
    
    func createUser(email: String, password: String, name: String, username: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            await uploadUserData(userId: userId, email: email, username: username, name: name)
        } catch {
            print("failed to create user, \(error.localizedDescription)")
        }
    }
    
    func uploadUserData(userId: String, email: String, username: String, name: String) async {
        let user = User(id: userId, email: email, username: username, name: name)
        self.currentUser = user
        
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) // user.id를 document의 Key로 사용
        } catch {
            print("Failed to upload User Data, \(error.localizedDescription)")
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password) // Auth.auth().currentUser에 로그인 한 사용자가 삽입
            currentAuthUser = result.user
            await loadCurrentUserData()
        } catch {
            print("Failed to login, \(error.localizedDescription)")
        }
    }
    
    func loadCurrentUserData() async {
        guard let userId = self.currentAuthUser?.uid else { return }
        do {
            self.currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self) // 직접 만든 User 타입으로 값을 가져옴
        } catch {
            print("Failed to load User data, \(error.localizedDescription)")
        }
    }
    
    func loadUserData(userId: String) async -> User? {
        do {
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            return user
        } catch {
            print("Failed to load User data, \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadAllUserData() async -> [User]? {
        do {
            let documents = try await Firestore.firestore().collection("users").getDocuments().documents
            let users = try documents.compactMap { document in
                return try document.data(as: User.self)
            }
            return users
        } catch {
            print("Failed to load all user data, \(error.localizedDescription)")
            return nil
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut() // Firebase Auth 로그아웃 (currentUser를 nil로 만들어줌)
            currentAuthUser = nil
            currentUser = nil
        } catch {
            print("Failed to signout, \(error.localizedDescription )")
        }
    }
}
