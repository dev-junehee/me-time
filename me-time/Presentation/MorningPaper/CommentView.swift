//
//  CommentView.swift
//  me-time
//
//  Created by junehee on 9/23/24.
//

import SwiftUI
import RealmSwift

struct CommentView: View {
    
    private enum CreateCommentResultCase: String {
        case pending
        case empty =  "댓글을 작성해 주세요. ✍️"
        case noData = "해당 데이터가 없어요!"
        case already = "오늘 날짜의 댓글이 이미 기록되었어요!"
        case success = "댓글 등록이 성공했어요.🍀"
    }
    
    @ObservedRealmObject var detailData: MorningPaper

    @Binding var showComment: Bool
    
    @State private var commentText = ""
    
    @State private var createCommentResult: CreateCommentResultCase = .pending
    @State private var showAlert = false
    
    private let dateFormatterRepo = DateFormatterRepository()
    
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
                ForEach(comments, id: \.id) { comment in
                    commentView(comment)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
    }
    
    /// 댓글 셀
    private func commentView(_ comment: Comment) -> some View {
        HStack(alignment: .top, spacing: 4) {
            Text(comment.content)
                .font(.gowunRegular14)
            Spacer()
            Text(dateFormatterRepo.getFormattedDateString(date: comment.createAt))
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
                createComment { result in
                    switch result {
                    case .pending:
                        return
                    case .empty:
                        showAlert.toggle()
                    case .noData:
                        showAlert.toggle()
                    case .already:
                        showAlert.toggle()
                        showComment.toggle()
                    case .success:
                        return
                    }
                }
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
            .alert(createCommentResult.rawValue,
                   isPresented: $showAlert,
                   presenting: Constant.Button.alert) { (_, okay) in
                Button(okay) { showAlert.toggle() }
            }
        }
        .frame(height: 46)
        .padding(.horizontal, 20)
        .background(.primaryGreen)
    }
    
    private func createComment(completion: @escaping (CreateCommentResultCase) -> ()) {
        guard !commentText.isEmpty else {
            completion(.empty)
            createCommentResult = .empty
            return
        }
            
        let comment = Comment(content: commentText)
        
        do {
            let realm = try Realm()
            let data = realm.object(ofType: MorningPaper.self,
                                    forPrimaryKey: detailData.id)
            
            /// Realm에 데이터가 없는 경우
            guard let data = data else {
                completion(.noData)
                createCommentResult = .noData
                commentText = ""
                return
            }
            
            let hasToday = data.commentData.contains { item in
                var current = Calendar.current
                current.timeZone = TimeZone(identifier: "Asia/Seoul")!
                print("current", current)
                return current.isDateInToday(item.createAt)
            }
            print("hasToday", hasToday)
            
            /// 오늘 날짜 댓글이 이미 있는 경우
            guard !hasToday else {
                completion(.already)
                createCommentResult = .already
                commentText = ""
                return
            }
            
            try realm.write {
                data.commentData.append(comment)
            }
            commentText = ""
            completion(.success)
        } catch {
            print("Real 에러 났어요: \(error.localizedDescription)")
        }
    }
    
}
