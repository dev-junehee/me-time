//
//  MusicView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct MusicView: View {
    
    @State private var playList: [YouTubeSearchItems] = []
    
    var body: some View {
        VStack {
            titleView()
            if !playList.isEmpty {
                playListView()
            }
        }
        .task {
            fetchPlayList()
        }
        
    }
    
    /// 상단 타이틀
    private func titleView() -> some View {
        HStack {
            Text("이런 음악은 어때요?")
                .font(.gowunRegular26)
                .bold()
            Spacer()
        }
        .padding([.top, .horizontal], 20)
    }
    
    /// 플레이리스트 페이지네이션 (탭뷰 버전)
    // private func playListViewTabViewVersion() -> some View {
    //     TabView {
    //         ForEach(playList, id: \.id) { item in
    //             playListCell(item)
    //                 .aspectRatio(contentMode: .fit)
    //         }
    //     }
    //     .tabViewStyle(.page)
    //     .frame(maxWidth: .infinity)
    //     .frame(height: 300)
    //     .background(.blue)
    // }
    
    /// 플레이리스트 스크롤뷰
    private func playListView() -> some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(playList, id: \.id) { item in
                    playListCell(item)
                }
            }
            .padding(.bottom, 100)
        }
    }
    
    /// 플레이리스트 셀 (클릭 시 웹 뷰 push)
    private func playListCell(_ item: YouTubeSearchItems) -> some View {
        NavigationLink {
            MusicDetailView(url: "https://www.youtube.com/watch?v=\(item.id.videoId)")
        } label: {
            VStack {
                AsyncImage(url: URL(string: item.snippet.thumbnails.medium.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                } placeholder: {
                    ProgressView()
                }
                Text(item.snippet.title)
                    .font(.gowunRegular14)
                    .frame(height: 20)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    .foregroundStyle(.primaryBlack)
            }
        }
        .frame(height: 350)
    }
    
    /// 추천 플레이리스트 데이터 가져오기
    private func fetchPlayList() {
        let todayEmotion = UserDefaultsManager.todayEmotion == "None" 
                                ? Constant.TodayEmotion.AllEmotions.allCases.map { $0.rawValue }.randomElement()!
                                : UserDefaultsManager.todayEmotion
        
        guard let queryEmotion = todayEmotion.split(separator: "요").first else { return }
        let query = "\(queryEmotion) 노래 playlist"
        
        YoutubeAPIManager.shared.searchMusic(query) { result in
            switch result {
            case .success(let value):
                print("Youtube API Success ✨✨✨")
                dump(value)
                playList = value
            case .failure(let error):
                print("Youtube API error 🚨🚨🚨", error)
                playList = []
            }
        }
    }
    
}
