//
//  MusicView.swift
//  me-time
//
//  Created by junehee on 9/15/24.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        Text("Music View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan)
            .onAppear {
                YoutubeAPIManager.shared.searchMusic("행복 노래 playlist") { result in
                    switch result {
                    case .success(let value):
                        print("Youtube API Success ✨✨✨")
                        dump(value)
                    case .failure(let error):
                        print("Youtube API error 🚨🚨🚨", error)
                    }
                }
            }
    }
    
}

#Preview {
    MusicView()
}
