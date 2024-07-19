//
//  ImageManager.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

class ImageManager {
    static func convertImage(item: PhotosPickerItem?) async -> ImageSelection? { // async 키워드를 붙여서 동시성 처리의 책임을 상위 함수로 보내버림
        guard let item = item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return nil } // 이진수의 데이터 형식으로 변환
            // lodaTransferable 메서드가 throws 메서드이므로 try?로 에러 핸들링 후 옵셔널 추출
            // lodaTransferable 메서드가 async 메서드이므로 await 키워드 사용
        guard let uiImage = UIImage(data: data) else { return nil }
            // UIKit에서 사용하는 이미지 형식으로 변환
        let image = Image(uiImage: uiImage)
        
        let imageSelection = ImageSelection(image: image, uiImage: uiImage)
        return imageSelection
    }
    
    static func uploadImage(uiImage: UIImage, path: ImagePath) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil } // jpeg 이미지로 압축
        let fileName = UUID().uuidString // 임의의 문자열
        let reference = Storage.storage().reference(withPath: "/\(path)/\(fileName)") // DB에 저장할 경로 생성후 참조 반환
        /*
         switch path {
         case .posts:
            imagePath = "posts"
         case .profiles:
            imagePath = "profiles"
         }
         */
        do {
            let metaData = try await reference.putDataAsync(imageData) // 이미지를 저장하고, 저장된 정보와 관련한 메타 데이터 반환
            let url = try await reference.downloadURL()
            
            return url.absoluteString // 전체 주소 반환
        } catch {
            print("image upload failed \(error.localizedDescription)") // error 변수를 바로 사용 가능
            
            return nil
        }
    }
}


// 여러개의 값을 리턴할 때, 튜플로 리턴할 수도 있지만, 보통 구조체를 만들어서 리턴함 (리턴 모델)
struct ImageSelection {
    let image: Image
    let uiImage: UIImage
}

enum ImagePath {
    case posts
    case porfiles
}
