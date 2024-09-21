//
//  TodayEmotionView.swift
//  me-time
//
//  Created by junehee on 9/16/24.
//

import SwiftUI

struct TodayEmotionView: View {
    
    @Binding var isTodayEmotion: Bool
    @Binding var selectedTodayEmotion: String
    
    /// 긍정/부정 감정 데이터
    @State private var positive = Constant.TodayEmotion.Positive.allCases.shuffled()
    @State private var negative = Constant.TodayEmotion.Negative.allCases.shuffled()
    
    /// 더 보기 -  Full Screen Present
    @State private var isPresent = false
    /// 감정 버튼 클릭 시 Alert
    @State private var showAlert = false
    
    private enum EmotionType {
        case positive
        case negative
    }
    
    var body: some View {
        NavigationView {
            VStack {
                titleView()
                emotionCellList()
                moreButton()
            }
            .toolbar {
                /// `Dismiss`
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isTodayEmotion.toggle()
                    }, label: {
                        Image(.backButton)
                    })
                }
            }
        }
        
    }
    
    /// 상단 타이틀 텍스트
    private func titleView() -> some View {
        VStack(alignment: .leading) {
            Text("Today’s First Emotion")
                .font(.serifRegular30)
            Text("오늘의 첫 번째 감정은 어떠신가요?")
                .font(.gowunRegular14)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 100)
        .padding(.top, 10)
        .padding(.horizontal, 20)
    }
    
    /// 감정 셀 리스트
    private func emotionCellList() -> some View {
        HStack {
            VStack {
                ForEach(0..<6, id: \.self) { idx in
                    let title = positive[idx].rawValue
                    emotionCell(title, type: .positive)
                }
            }
            
            VStack {
                ForEach(0..<6, id: \.self) { idx in
                    let title = negative[idx].rawValue
                    emotionCell(title, type: .negative)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    /// 감정 셀
    private func emotionCell(_ title: String, type: EmotionType) -> some View {
        Button(action: {
            /// 버튼 클릭 시 오늘의 감정 저장 후 확인용 Alert
            selectedTodayEmotion = title
            showAlert.toggle()
        }, label: {
            ZStack {
                Rectangle()
                    .fill(type == .positive ? .primarySand : .primaryGreen)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .asButtonShape()
                Text(title)
                    .font(.gowunRegular14)
                    .foregroundColor(.primaryBlack)
            }
        })
        .alert("오늘의 첫 번째 감정을 '\(selectedTodayEmotion)'로 저장할까요?", 
               isPresented: $showAlert,
               presenting: Constant.Button.alert) { (cancel, okay) in
            Button(cancel, role: .cancel) {
                selectedTodayEmotion = ""   /// 취소 누르면 선택한 감정 초기화
            }
            Button(okay) {
                print(selectedTodayEmotion)
                isTodayEmotion.toggle()     /// 오늘의 감정 선택창 Dismiss
            }
        }
    }
    
    /// 더 보기 버튼
    private func moreButton() -> some View {
        Button(action: {
            isPresent.toggle()
        }, label: {
            Text("더 보기")
                .font(.caption)
                .bold()
                .foregroundStyle(.primaryBlack)
                .padding(.bottom, 20)
        })
        .fullScreenCover(isPresented: $isPresent,
                         content: {
            AllTodayEmotionView(selectedEmotion: $selectedTodayEmotion, 
                                isPresent: $isPresent, 
                                isTodayEmotion: $isTodayEmotion)
            
        })
    }
}


struct AllTodayEmotionView: View {

    @State private var emotionList = Constant.TodayEmotion.AllEmotions.allCases
    
    @Binding var selectedEmotion: String
    @Binding var isPresent: Bool
    @Binding var isTodayEmotion: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(emotionList, id: \.self) { item in
                    Button(action: {
                        selectedEmotion = item.rawValue
                    }, label: {
                        HStack {
                            Text(item.rawValue)
                                .font(.gowunRegular14)
                                .fontWeight(selectedEmotion == item.rawValue ? .bold : .regular)
                            Spacer()
                            Image(systemName: selectedEmotion == item.rawValue ? "checkmark.circle.fill" : "checkmark.circle").fontWeight(.light)
                                .foregroundColor(selectedEmotion == item.rawValue ? .primaryGreen : .primaryBlack)
                        }
                    })
                    .foregroundStyle(.primaryBlack)
                }
            }
            .onAppear {
                emotionList.shuffle()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("닫기") {
                        isPresent.toggle()
                    }
                    .foregroundStyle(.primaryBlack)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        print("저장 버튼 눌렀을 때 값: ", selectedEmotion)
                        isPresent.toggle()
                        isTodayEmotion.toggle()
                    }
                    .bold()
                    .foregroundStyle(.primaryBlack)
                }
            }
        }
        
    }
    
}




