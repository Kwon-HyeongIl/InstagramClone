//
//  InstagramTextFieldModifier.swift
//  InstagramClone
//
//  Created by 권형일 on 7/13/24.
//

import SwiftUI

struct InstagramTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content // TextField에 사용할 경우, TextField가 content에 들어와서 아래의 수정자들을 붙이고 리턴됨
            .textInputAutocapitalization(.never) // 첫글자 대문자로 설정되는거 방지
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay { // 테두리 설정을 위한 겹치기
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1) // 테두리에만 설정
            }
            .padding(.horizontal) // 좌우만 패딩 넣기
    }
}
