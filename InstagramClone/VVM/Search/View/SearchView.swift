//
//  SearchView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/19/24.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    
    var body: some View {
        ForEach(viewModel.users) { user in
            Text(user.username)
        }
    }
}

#Preview {
    SearchView()
}
