//
//  FeedCellView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import SwiftUI

struct FeedCellView: View {
    var body: some View {
        VStack {
            Image("profile_owl")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HStack {
                        Image("instagramLogo")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color(red: 191/255, green: 11/255, blue: 180/255), lineWidth: 2)
                            }
                        
                        Text("유저네임 입니다")
                            .foregroundStyle(.white)
                            .bold()
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                    .padding(8)
            }
            
            HStack {
                Image(systemName: "heart")
                
                Image(systemName: "bubble.right")
                
                Image(systemName: "paperplane")
                Spacer()
                
                Image(systemName: "bookmark")
            }
            .imageScale(.large)
            .padding(.horizontal, 10)
            
            Text("좋아요 n개")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("닉네임, 상세 글 정보")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("댓글 n개 더보기")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            Text("n분전")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .padding(.bottom)
    }
}

#Preview {
    FeedCellView()
}
