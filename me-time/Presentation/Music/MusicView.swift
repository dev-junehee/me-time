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
        VStack(alignment: .leading) {
            titleView()
            playListView()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            fetchPlayList()
        }
        
    }
    
    /// 상단 타이틀
    private func titleView() -> some View {
        Text("이런 음악은 어때요?")
            .font(.gowunRegular26)
            .bold()
            .padding(.horizontal, 20)
    }
    
    /// 플레이리스트 페이지네이션
    private func playListView() -> some View {
        TabView {
            ForEach(playList, id: \.id) { item in
                playListCell(item)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .tabViewStyle(.page)
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(.blue)
    }
    
    /// 플레이리스트 셀 (클릭 시 웹 뷰 push)
    private func playListCell(_ item: YouTubeSearchItems) -> some View {
        NavigationLink {
            MusicDetailView(url: "https://www.youtube.com/watch?v=\(item.id)")
        } label: {
            VStack {
                AsyncImage(url: URL(string: item.snippet.thumbnails.medium.url))
                    .frame(width: CGFloat(item.snippet.thumbnails.medium.width),
                           height: CGFloat(item.snippet.thumbnails.medium.height))
                Text(item.snippet.title)
                    .frame(width: .infinity)
                    .lineLimit(0)
            }
        }
        // .frame(maxHeight: 300)
        // .padding(.horizontal, 30)
        .background(.yellow)
    }
    
    /// 추천 플레이리스트 데이터 가져오기
    private func fetchPlayList() {
        guard let emotion = "행복해요".split(separator: "요").first else { return }
        let query = "\(emotion) 노래 playlist"
        
        YoutubeAPIManager.shared.searchMusic(query) { result in
            switch result {
            case .success(let value):
                print("Youtube API Success ✨✨✨")
                dump(value)
                playList = value
            case .failure(let error):
                print("Youtube API error 🚨🚨🚨", error)
            }
        }
    }
    
}
