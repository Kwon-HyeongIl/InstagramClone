//
//  CommentView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import SwiftUI

struct CommentView: View {
    @State var commentText = ""
    
    var body: some View {
        VStack {
            Text("댓글")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .padding(.top, 30)
            
            Divider()
            
            ScrollView {
                LazyVStack {
                    Text("comment")
                }
            }
            
            Divider()
            
            HStack {
                Image("profile_owl")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                TextField("댓글 작성", text: $commentText, axis: .vertical) // axis로 .vertical로 설정할 경우, 화면을 초과해서 글이 입력 되었을 경우 수직으로 창이 늘어남
                
                Button {
                    
                } label: {
                    Text("보내기")
                }
            }
            .padding()
        }
    }
}

#Preview {
    CommentView()
}
