//
//  Post.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String // 게시글 식별자
    let userId: String
    let caption: String
    var like: Int
    let imageUrl: String
    let date: Date
    var isLike: Bool?
    
    var user: User?
}

// 더미 데이터
extension Post {
    static var DUMMY_POST: Post = Post(id: UUID().uuidString, userId: UUID().uuidString, caption: "test caption", like: 24, imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-9393f.appspot.com/o/images%2F2C57FEC1-B394-43AC-8C3C-787861D2C584?alt=media&token=a6ba8fb7-776d-4b01-b781-1c5304b414f3", date: Date())
}
