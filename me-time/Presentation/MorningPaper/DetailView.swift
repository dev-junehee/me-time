//
//  DetailView.swift
//  me-time
//
//  Created by junehee on 9/21/24.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
    
    @ObservedRealmObject var detailData: MorningPaper
    
    var body: some View {
        VStack(alignment: .leading) {
            dateTextView(date: detailData.createAt, emotion: detailData.emotion)
            titleFieldView(title: detailData.title)
            contentFieldView(content: detailData.content)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
    
    /// 상단 날짜
    private func dateTextView(date: Date, emotion: String) -> some View {
        HStack {
            Text(DateFormatterManager.getFormattedDateString(date: date))
                .font(.morenaBold14)
                .padding(.top, 20)
            Spacer()
            Text(emotion)
                .font(.gowunRegular14)
                .foregroundStyle(.primaryBlack)
        }
        
    }
    
    /// 모닝페이퍼 제목
    private func titleFieldView(title: String) -> some View {
        Text(title)
            .font(.gowunRegular20)
            .bold()
            .asCustomBackButton()
    }
    
    /// 모닝페이퍼 내용
    private func contentFieldView(content: String) -> some View {
        ZStack {
            /// background 라운드 처리
            RoundedRectangle(cornerRadius: 10)
                .stroke(.primaryGray, lineWidth: 2)
                .font(.gowunRegular14)
                .overlay(alignment: .topLeading) {
                    Text(content)
                        .font(.gowunRegular12)
                        .padding(10)
                }
                .border(.primaryGray)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

