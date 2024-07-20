//
//  SearchView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @State var searchText = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                return user.username.lowercased().contains(searchText.lowercased()) // 조건에 맞는것들만 리턴
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredUsers) { user in // List로 지연 로딩
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label: {
                    HStack {
                        if let imageUrl = user.profileImageUrl {
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 53, height: 53)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 53, height: 53)
                                .opacity(0.5)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(user.username)
                            Text(user.bio ?? "")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "검색") // 검색하는 화면에 들어가는 것이므로 NavigationStack과 같이 써야됨
        }
    }
}

#Preview {
    SearchView()
}
