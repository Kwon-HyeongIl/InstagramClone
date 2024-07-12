//
//  NewPostView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State private var caption = ""
    @Binding var tabIndex: Int
    @State var selectedItem: PhotosPickerItem?
    @State var postImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async { // async 키워드를 붙여서 동시성 처리의 책임을 상위 함수로 보내버림
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return } // 이진수의 데이터 형식으로 변환
            // lodaTransferable 메서드가 throws 메서드이므로 try?로 에러 핸들링 후 옵셔널 추출
            // lodaTransferable 메서드가 async 메서드이므로 await 키워드 사용
        guard let uiImage = UIImage(data: data) else { return }
            // UIKit에서 사용하는 이미지 형식으로 변환
        
        self.postImage = Image(uiImage: uiImage)
    }
    
    var body: some View {
        VStack {
            
            /*
             상단바
             */
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
            
            
            /*
             이미지 파트
             */
            PhotosPicker(selection: $selectedItem) { // PhotosUI에서 제공하는 사진 선택 기능 구조체
                if let image = self.postImage { // 사진 삽입 후
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
            .onChange(of: selectedItem) { oldValue, newValue in // 이미지 변화(삽입 및 수정)를 감지
                Task { // 동시성 처리의 책임을 상위 함수로 보냈기 때문에, 그 함수를 호출하는 여기서 동시성 처리
                    await convertImage(item: newValue)
                }
            }
            
            /*
             글 작성 파트
             */
            TextField("문구를 작성하세요!", text: $caption)
                .padding()
            
            Spacer()
            
            /*
             공유 버튼 파트
             */
            Button {
                print("공유")
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
