//
//  FeedView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/16/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                    Spacer()
                    
                    Image(systemName: "heart")
                        .imageScale(.large)

                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                
                FeedCellView()
                
                Spacer()
            }
        }
    }
}

#Preview {
    FeedView()
}
