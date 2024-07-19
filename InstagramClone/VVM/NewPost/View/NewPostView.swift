//
//  NewPostView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Binding var tabIndex: Int
    @State var viewModel = NewPostViewModel() // View Model의 변화를 감지하기 위해 @State 사용
    
    var body: some View {
        VStack {
            
            HStack {
                
                // 뒤로가기 버튼
                Button {
                    tabIndex = 0 // MainTabView의 0번 탭으로 변경
                } label: { // Swift 5.3의 멀티 후행 클로저 문법 사용
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
                
                Spacer()
                
                // 제목
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal)
            
            PhotosPicker(selection: $viewModel.selectedItem) { // PhotosUI에서 제공하는 사진 선택 기능 구조체
                if let image = self.viewModel.postImage { // 사진 삽입 후
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill) // 숫자를 안썼으므로 원본 비율을 따름
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                    
                } else { // 사진 삽입 전
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
//                        .tint(.black)
                            // 상위 뷰인 MainTabView에서 틴트를 블랙으로 설정하였으므로, 하위 뷰에는 블랙이 기본값이 됨
                }
            }
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in // 이미지 변화(삽입 및 수정)를 감지
                Task { // 동시성 처리의 책임을 상위 함수로 보냈기 때문에, 그 함수를 호출하는 여기서 동시성 처리
                    await viewModel.convertImage(item: newValue)
                }
            }

            TextField("문구를 작성하세요!", text: $viewModel.caption)
                .padding()
            
            Spacer()

            Button {
                Task {
                    await viewModel.uploadPost()
                    viewModel.clearData()
                    tabIndex = 0
                }
            } label: {
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2))
}
