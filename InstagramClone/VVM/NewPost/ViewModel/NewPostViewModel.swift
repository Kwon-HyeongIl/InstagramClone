//
//  NewPostViewModel.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI // SwiftUI가 Foundation을 포함
import PhotosUI
import FirebaseStorage

import Firebase
import FirebaseFirestoreSwift

@Observable // Observable이 프로퍼티들을 감시하므로 프로퍼티에 @State는 필요없음
class NewPostViewModel {
    var caption = ""
    var selectedItem: PhotosPickerItem?
    var postImage: Image?
    var uiImage: UIImage?
    
    func convertImage(item: PhotosPickerItem?) async { // async 키워드를 붙여서 동시성 처리의 책임을 상위 함수로 보내버림
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.postImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func uploadPost() async {
        
        guard let uiImage else { return } // 변수명이 같을 때는 "= 옵셔널 변수" 생략 가능
        guard let imageUrl = await ImageManager.uploadImage(uiImage: uiImage, path: .posts) else { return }
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
        
        let postReference = Firestore.firestore().collection("posts").document() // firebase에서 Collection이 스키마, document가 원소
        let post = Post(id: postReference.documentID, userId: userId, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
            // postReference.documentID를 사용하면 postReference에서 임의의 아이디를 하나 제공 해줌
            // Date()를 사용하면 현재 시간을 제공해줌
        
        do {
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("failed to upload, \(error.localizedDescription)")
        }
    }
    
    // 게시글 업로드 후 다시 업로드 창으로 들어갔을때 비워져있어야 되므로, 관련 데이터들을 다 삭제
    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
}
