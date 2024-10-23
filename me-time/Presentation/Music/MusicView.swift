//
//  MusicView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct MusicView: View {

    @Environment(\.isTabBarHidden) private var isTabBarHidden: Binding<Bool>
    
    @State private var isLoading = true
    @State private var isFirstLoading = true
    @State private var playList: [YouTubeSearchItems] = []
    
    var body: some View {
        VStack {
            titleView()
            if !playList.isEmpty {
                if isLoading {
                    ProgressView()
                } else {
                    playListView()
                }
            } else {
                ProgressView()
            }
        }
        .task {
            if isFirstLoading {
                print("한 번만 실행되어야 함")
                fetchPlayList()
                isFirstLoading = false
            }
        }
        
    }
    
    /// 상단 타이틀
    private func titleView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("이런 음악은 어때요?")
                    .font(.gowunRegular26)
                    .bold()
                Spacer()
            }
            Text("오늘의 기분에 맞는 음악을 추천드려요. 🎧")
                .font(.gowunRegular16)
        }
        .padding([.top, .horizontal, .bottom], 20)
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
                .environment(\.isTabBarHidden, isTabBarHidden)
        } label: {
            HStack {
                AsyncImage(url: URL(string: item.snippet.thumbnails.high.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 120)
                        .cornerRadius(20, corners: .allCorners)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 180, height: 120)
                
                VStack(alignment: .leading) {
                    Text(item.snippet.title)
                        .font(.gowunRegular14)
                        .bold()
                        .foregroundStyle(.primaryBlack)
                        .frame(height: 70, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Text(item.snippet.channelTitle)
                        .font(.caption)
                        .foregroundStyle(.primaryBlack.opacity(0.5))
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: 120)
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
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
                playList = value
                isLoading = false
            case .failure(let error):
                print("Youtube API error 🚨🚨🚨", error)
                playList = []
            }
        }
    }
    
}
