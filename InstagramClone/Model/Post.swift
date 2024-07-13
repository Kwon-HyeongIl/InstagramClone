//
//  Post.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import Foundation

struct Post: Codable {
    let id: String // 게시글 식별자
    let caption: String
    var like: Int
    let imageUrl: String
    let date: Date
}
