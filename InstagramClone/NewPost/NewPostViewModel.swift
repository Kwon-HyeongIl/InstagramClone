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
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return } // 이진수의 데이터 형식으로 변환
            // lodaTransferable 메서드가 throws 메서드이므로 try?로 에러 핸들링 후 옵셔널 추출
            // lodaTransferable 메서드가 async 메서드이므로 await 키워드 사용
        guard let uiImage = UIImage(data: data) else { return }
            // UIKit에서 사용하는 이미지 형식으로 변환
        
        self.postImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    func uploadPost() async {
        
        guard let uiImage else { return } // 변수명이 같을 때는 "= 옵셔널 변수" 생략 가능
        guard let imageUrl = await uploadImage(uiImage: uiImage) else { return }
        
        let postReference = Firestore.firestore().collection("posts").document() // firebase에서 Collection이 스키마, document가 원소
        let post = Post(id: postReference.documentID, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
            // postReference.documentID를 사용하면 postReference에서 임의의 아이디를 하나 제공 해줌
            // Date()를 사용하면 현재 시간을 제공해줌
        
        do {
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("failed to upload, \(error.localizedDescription)")
        }
    }
    
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil } // jpeg 이미지로 압축
        let fileName = UUID().uuidString // 임의의 문자열
        
        let reference = Storage.storage().reference(withPath: "/images/\(fileName)") // DB에 저장할 경로 생성후 반환
        
        do {
            let metaData = try await reference.putDataAsync(imageData) // 이미지를 저장하고, 저장된 정보와 관련한 메타 데이터 반환
            let url = try await reference.downloadURL()
            
            return url.absoluteString // 전체 주소 반환
        } catch {
            print("image upload failed \(error.localizedDescription)") // error 변수를 바로 사용 가능
            
            return nil
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
