//
//  WritingView.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import SwiftUI

struct WritingView: View {
    
    @Binding var isWritingViewPresent: Bool
    
    @State private var titleText = ""
    @State private var contentText = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                dateTextView()
                titleFieldView()
                contentFieldView()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .toolbar {
                /// `Dismiss`
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isWritingViewPresent.toggle()
                    }, label: {
                        Image(.backButton)
                    })
                }
                /// `Done`
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("완료 처리")
                    }, label: {
                        Text("Done")
                            .baselineOffset(-8)
                            .font(.morenaBold16)
                            .foregroundStyle(.primaryBlack)
                    })
                }
            }
        }
    }
    
    /// 상단 날짜
    private func dateTextView() -> some View {
        Text(DateFormatterManager.getTodayString())
            .font(.morenaBold14)
            .padding(.top, 20)
    }
    
    /// 모닝페이퍼 제목
    private func titleFieldView() -> some View {
        TextField("제목을 입력해 주세요.", text: $titleText, prompt: Text("제목을 입력해 주세요.").font(.gowunRegular20))
            .font(.gowunRegular20)
            .bold()
    }
    
    /// 모닝페이퍼 내용
    private func contentFieldView() -> some View {
        ZStack {
            /// background 라운드 처리
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primaryGray, lineWidth: 1)
            /// 실제 컨텐츠 부분
            TextEditor(text: $contentText)
                .font(.gowunRegular14)
                .overlay(alignment: .topLeading) {
                    Text(Constant.MorningPaper.contentPlaceholder)
                        .foregroundStyle(contentText.isEmpty ? .gray : .clear)
                        .font(.gowunRegular12)
                        .padding(10)
                }
                .border(.primaryGray)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}
