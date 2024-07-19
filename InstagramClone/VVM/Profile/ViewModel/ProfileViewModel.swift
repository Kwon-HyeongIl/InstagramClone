//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/15/24.
//

import SwiftUI
import Firebase
import PhotosUI
import FirebaseStorage

@Observable
class ProfileViewModel {
    var user: User?
    
    var name: String
    var username: String
    var bio: String
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    var posts: [Post] = []
    
    // 내 프로필 보기
    init() {
        let tempUser = AuthManager.shared.currentUser
        self.user = tempUser
        
        self.name = tempUser?.name ?? "" // "??" nil일 경우 오른쪽 값이 기본값으로 사용
        self.username = tempUser?.username ?? ""
        self.bio = tempUser?.bio ?? ""
    }
    
    // 다른 사람 프로필 보기
    init(user: User) {
        self.user = user
        self.name = user.name
        self.username = user.username
        self.bio = user.bio ?? ""
        
        isFollow()
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func updateUser() async {
        do {
            try await updateUserRemote() // 서버의 값이 바뀌지 않으면 로컬 값도 바뀌면 안되므로, Remote 메서드를 먼저 호출
            updateUserLocal()
        } catch {
            print("Failed to update User data, \(error.localizedDescription)")
        }
    }
    
    func updateUserLocal() {
        if name != "", name != user?.name { // 스위프트에서는 And 연산자 '&&' 대신 ',' 사용 가능
            user?.name = name
        }
        
        if !username.isEmpty, username != user?.username {
            user?.username = username
        }
        
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    func updateUserRemote() async throws {
        var editedData: [String : Any] = [:]
        
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        
        if !username.isEmpty, username != user?.username {
            editedData["username"] = username
        }
        
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        
        if let uiImage = self.uiImage {
            guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .porfiles) else { return }
            editedData["profileImageUrl"] = imageUrl
        }
        
        if !editedData.isEmpty, let userId = user?.id { // 오른쪽 경우는 옵셔널 바인딩이 성공할 경우 True
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData) // Fire Store 내에서 수정된 값만 업데이트 해줌
        }
    }
    
    func loadUserPosts() async {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: user?.id ?? "").getDocuments().documents
            
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self) // 리턴으로 받은 QueryDocumentSnapshot 타입의 값을 Post 타입의 값으로 변경
                posts.append(post)
            }
            self.posts = posts
            
        } catch {
            print("Failed to load User posts, \(error.localizedDescription)")
        }
    }
}
