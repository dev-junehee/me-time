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
    
    @State private var showComment = false
    
    var body: some View {
        VStack(alignment: .leading) {
            dateTextView(date: detailData.createAt)
            titleFieldView(title: detailData.title)
            todayEmotionView(emotion: detailData.emotion)
            contentFieldView(content: detailData.content)
        }
        .asCustomBackButton()
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    print("댓글창")
                    showComment.toggle()
                }, label: {
                    Image(systemName: "ellipsis.message.fill")
                        .foregroundStyle(.primaryGreen)
                })
            }
        }
        .sheet(isPresented: $showComment) {
            CommentView(detailData: detailData, showComment: $showComment)
                .presentationDetents([.medium, .large])
        }
    }
    
    /// 상단 날짜
    private func dateTextView(date: Date) -> some View {
        HStack {
            Text(DateFormatterManager.getFormattedDateString(date: date))
                .font(.morenaBold14)
                .padding(.top, 20)
        }
        
    }
    
    /// 모닝페이퍼 제목
    private func titleFieldView(title: String) -> some View {
        Text(title)
            .font(.gowunRegular20)
            .bold()
            .padding(.bottom, 1)
    }
    
    /// 모닝페이퍼 오늘의 첫 번째 감정
    private func todayEmotionView(emotion: String) -> some View {
        HStack(alignment: .lastTextBaseline) {
            Spacer()
            Text("이날의 첫 번째 감정은")
                .font(.gowunRegular12)
            if let emotionCase = Constant.TodayEmotion.AllEmotions(rawValue: emotion) {
                Text("\(emotion) \(emotionCase.emotionEmoji)")
                    .foregroundStyle(.primaryBlack)
                    .bold()
                    .font(.gowunRegular14)
            }
        }
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

