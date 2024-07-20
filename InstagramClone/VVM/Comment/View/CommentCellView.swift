//
//  CommentCellView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import SwiftUI
import Kingfisher

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            if let imageUrl = comment.commentUser?.profileImageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(comment.commentUser?.username ?? "")
                    
                    Text(comment.date.relativeTimeString())
                        .foregroundStyle(.gray)
                }
                
                Text(comment.commentText)
            }
        }
    }
}

#Preview {
    CommentCellView(comment: Comment.DUMMY_COMMENT)
}
