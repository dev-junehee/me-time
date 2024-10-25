//
//  WritingView.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import SwiftUI
import RealmSwift

struct WritingView: View {
    
    private enum CreateResultCase: String {
        case pending
        case empty =  "오늘의 기록을 완성해 주세요. 🕯️"
        case already = "오늘 날짜의 모닝페이퍼가 이미 기록되었어요!"
        case success
    }
    
    @Binding var isWritingViewPresent: Bool  /// 메인에서 작성창 Present-Dismiss
    
    @State private var isTodayEmotion = false   /// 작성창에서 오늘의 감정 선택 Present-Dismiss
    
    /// 모닝페이퍼 제목, 내용, 오늘의 첫 번째 감정
    @State private var titleText = ""
    @State private var contentText = ""
    @State private var selectedTodayEmotion = ""
    
    /// 모닝페이퍼 생성 결과값
    @State private var showAlert = false
    @State private var createResult: CreateResultCase = .pending
    
    private let repository = MorningPaperTableRepository()
    
    /// Realm 모닝페이퍼 데이터
    @ObservedResults(MorningPaper.self) var morningPaperList

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
                        /// 모닝페이퍼 생성 - 작성 창 dismiss - toast
                        createMorningPaper { result in
                            switch result {
                            case .pending:
                                return
                            case .empty:
                                showAlert.toggle()
                            case .already:
                                showAlert.toggle()
                            case .success:
                                isWritingViewPresent.toggle()
                            }
                        }
                    }, label: {
                        Text("Done")
                            .baselineOffset(-8)
                            .font(.morenaBold16)
                            .foregroundStyle(.primaryBlack)
                    })
                    .alert(createResult.rawValue,
                           isPresented: $showAlert,
                           presenting: Constant.Button.alert) { (_, okay) in
                        Button(okay) {
                            showAlert.toggle()
                            if createResult == .already {
                                isWritingViewPresent.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// 상단 날짜
    private func dateTextView() -> some View {
        HStack {
            Text(DateFormatterManager.getFormattedTodayString())
                .font(.morenaBold14)
                .padding(.top, 20)
            Spacer()
            Button(action: {
                isTodayEmotion.toggle()
            }, label: {
                Text(selectedTodayEmotion == "" ? "오늘의 첫 번째 감정 선택" : selectedTodayEmotion)
                    .font(.gowunRegular14)
                    .foregroundStyle(.primaryBlack)
                    .bold()
            })
            .fullScreenCover(isPresented: $isTodayEmotion, content: {
                TodayEmotionView(isTodayEmotion: $isTodayEmotion, 
                                 selectedTodayEmotion: $selectedTodayEmotion)
            })
        }
        
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
                .background(.clear)
                .overlay(alignment: .topLeading) {
                    Text(Constant.MorningPaper.contentPlaceholder)
                        .foregroundStyle(contentText.isEmpty ? .gray : .clear)
                        .font(.gowunRegular12)
                        .padding(10)
                        .allowsHitTesting(false)
                }
                .border(.primaryGray)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    /// 모닝페이퍼 작성 기능
    private func createMorningPaper(completion: @escaping (CreateResultCase) -> ()) {
        /// 제목, 내용, 감정이 비어있는지 확인
        guard !titleText.isEmpty && !contentText.isEmpty && !selectedTodayEmotion.isEmpty else {
            completion(.empty)
            createResult = .empty
            return
        }
        
        /// 오늘 날짜의 데이터가 이미 존재하는지 확인
        let hasToday = morningPaperList.contains { item in
            var current = Calendar.current
            current.timeZone = TimeZone(identifier: "Asia/Seoul")!
            return current.isDateInToday(item.createAt)
        }
        
        guard !hasToday else {
            completion(.already)
            createResult = .already
            return
        }
        
        let morningPaper = MorningPaper(title: titleText, content: contentText, emotion: selectedTodayEmotion)
        $morningPaperList.append(morningPaper)
        
        titleText = ""
        contentText = ""
        selectedTodayEmotion = ""
        
        repository.detectRealmURL()
        completion(.success)
    }
}
