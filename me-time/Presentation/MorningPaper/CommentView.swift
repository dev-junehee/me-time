//
//  CommentView.swift
//  me-time
//
//  Created by junehee on 9/23/24.
//

import SwiftUI
import RealmSwift

struct CommentView: View {
    
    @ObservedRealmObject var detailData: MorningPaper
    
    @State private var commentText = ""
    
    var body: some View {
        VStack {
            commentTitleView()
            commentListView(Array(detailData.commentData))
            commentFieldView()
        }
    }
    
    /// 타이틀
    private func commentTitleView() -> some View {
        Text("Comments.")
            .font(.serifRegular16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.horizontal, 20)
    }
    
    /// 댓글 리스트
    private func commentListView(_ comments: [Comment]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(0..<20) { comment in
                    commentView()
                }
                
                // ForEach(comments, id: \.id) { comment in
                //     Text(comment.content)
                // }
            }
            .frame(maxWidth: .infinity)
            // .background(.gray)
        }
        .scrollIndicators(.hidden)
        // .padding(.top, 20)
        .padding(.horizontal, 20)
    }
    
    /// 댓글 셀
    private func commentView() -> some View {
        HStack(alignment: .top, spacing: 4) {
            Text("이런 생각을 했었구나~!")
                .font(.gowunRegular14)
            Spacer()
            Text("2024. 09. 20")
                .font(.system(size: 10))
                .foregroundStyle(.primaryBlack.opacity(0.5))
                .bold()
        }
        .frame(minHeight: 40)
    }
    
    /// 하단 댓글 필드 영역
    private func commentFieldView() -> some View {
        HStack {
            TextField(text: $commentText) {
                Text("댓글을 입력해 주세요")
            }
            .font(.gowunRegular14)
            
            Button(action: {
                print("댓글 등록", commentText)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.primarySand)
                    Text("등록")
                        .font(.gowunRegular12)
                        .bold()
                        .foregroundStyle(.primaryBlack)
                }
                .frame(width: 40, height: 30)
            })
        }
        .frame(height: 46)
        .padding(.horizontal, 20)
        .background(.primaryGreen)
    }
}
