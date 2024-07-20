//
//  MainTabView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) { // 탭 인덱스로 탭 각각을 태그
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            NewPostView(tabIndex: $tabIndex) // NewPostView와 연결
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)
            VStack {
                Text("Reels")
                
                Button {
                    AuthManager.shared.signout()
                } label: {
                    Text("로그아웃")
                }
            }
                .tabItem {
                    Image(systemName: "movieclapper")
                }
                .tag(3)
                
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(4)
        }
        .tint(Color.black) // 클릭(강조) 되었을 때의 색상 설정
        
    }
}

#Preview {
    MainTabView()
}
