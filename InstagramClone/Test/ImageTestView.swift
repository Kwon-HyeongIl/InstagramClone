//
//  ImageTestView.swift
//  InstagramClone
//
//  Created by 권형일 on 7/12/24.
//

import SwiftUI

struct ImageTestView: View {
    var body: some View {
        VStack {
            
            // 1_1 비율을 일정하게 프레임 안에 맞춤
            Image(systemName: "trash.square.fill")
                .resizable() // 뷰에서 차지할 수 있는 최대 영역 차지
                .aspectRatio(contentMode: .fit)
                    // 프레임 내에서 크기가 커지다가 한 변이라도 가득 차면 종료
//                .scaledToFit() // 바로 위의 코드와 동일한 코드
                .frame(width: 200, height: 100)
                .border(.red, width: 3)
                .padding()
                
            Spacer()
            
            // 1_2 비율을 직접 설정해서 프레임 안에 맞춤
            Image(systemName: "trash.square.fill")
                .resizable() // 뷰에서 차지할 수 있는 최대 영역 차지
                .aspectRatio(2, contentMode: .fit) // 만약 숫자를 안쓰면 원본 비율을 따름
                .frame(width: 200, height: 100)
                .border(.red, width: 3)
                .padding()
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            // 2_1 비율은 일정하지만 프레임 초과
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    // 프레임 내에서 크기가 커지다가 모든 변이 다 차야 종료
//                .scaledToFill() // 바로 위의 코드와 동일한 코드
                .frame(width: 200, height: 100)
                .border(.blue, width: 3)
                .padding()
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            // 2_2 비율은 일정하지만 프레임 초과된 부분을 자름
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                .scaledToFill() // 바로 위의 코드와 동일한 코드
                .frame(width: 200, height: 100)
                .border(.blue, width: 3)
                .clipped() // 프레임 비율에 맞춰서 이미지를 자름
                .padding()
            
            Spacer()
            
            // 2_3 비율을 직접 설정해서 초과된 부분을 자름
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/) // 만약 숫자를 안쓰면 원본 비율을 따름
                .frame(width: 200, height: 100)
                .border(.blue, width: 3)
                .clipped() // 프레임 비율에 맞춰서 이미지를 자름
                .padding()
        }
    }
}

#Preview {
    ImageTestView()
}
