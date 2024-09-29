//
//  ChangeNicknameView.swift
//  me-time
//
//  Created by junehee on 9/29/24.
//

import SwiftUI

struct ChangeNicknameView: View {
    
    @State private var nickname = ""
    
    @State private var showAlert = false
    @State private var alertTitle: NicknameAlertCase = .empty
    
    @Environment(\.dismiss) private var dismiss
    
    private enum NicknameAlertCase: String {
        case empty = "닉네임을 입력해 주세요."
        case whiteSpace = "공백은 포함될 수 없어요."
        case notOnlyEnglish = "닉네임은 영어만 가능해요."
        case isSuccess = "닉네임이 변경되었어요!✨\n이전 화면으로 돌아갈게요."
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("변경할 닉네임을 작성해 주세요!")
                .font(.gowunRegular20)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 60)
                .padding([.top, .horizontal], 20)
            
            TextField("e.g) Deah", text: $nickname)
                .font(.serifRegular20)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading) {
                Text("닉네임 규칙").bold()
                Text("(1) 영어만 가능해요.")
                Text("(2) 띄어쓰기와 특수문자를 포함할 수 없어요.")
                
            }
            .padding([.horizontal, .bottom], 20)
            .font(.caption)
            .foregroundStyle(.primaryBlack.opacity(0.5))
            
            CommonButton(title: "변경하기")
                .wrapToButton {
                    print("닉네임 변경 >>>", nickname)
                    changeNickname()
                }
                .alert(alertTitle.rawValue, 
                       isPresented: $showAlert,
                       presenting: Constant.Button.alert) { (_, okay) in
                    Button(okay) {
                        showAlert.toggle()
                        if alertTitle == .isSuccess {
                            dismiss()
                        }
                    }
                }
            
            Spacer()
        }
        .asCustomBackButton()
    }
    
    private func changeNickname() {
        /// 텍스트필드가 비어있는지 체크
        guard !nickname.isEmpty else { 
            alertTitle = .empty
            showAlert.toggle()
            return
        }
        
        /// 닉네임에 공백이 포함되어있는지 체크
        if nickname.contains(" ") {
            alertTitle = .whiteSpace
            showAlert.toggle()
            return
        }
        
        /// 닉네임이 영어인지 체크
        if isEnglishOnly(nickname) {
            print("영어에요 - 닉네임 변경")
            UserDefaultsManager.nick = nickname
            alertTitle = .isSuccess
            showAlert.toggle()
        } else {
            print("한글포함")
            alertTitle = .notOnlyEnglish
            showAlert.toggle()
        }
        
        
        
    }
    
    func isEnglishOnly(_ text: String) -> Bool {
        let regex = "^[a-zA-Z]+$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}

#Preview {
    ChangeNicknameView()
}
