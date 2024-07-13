//
//  ContentView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var signupViewModel = SignupViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUserSession != nil { // 로그인 한 상태일 경우
            MainTabView()
        } else {
            LoginView()
                .environment(signupViewModel) // LoginView를 포함한 하위 뷰들에서 signupViewModel을 사용 가능
        }
    }
}

#Preview {
    ContentView()
}
