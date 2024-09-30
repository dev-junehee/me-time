//
//  MusicDetailView.swift
//  me-time
//
//  Created by junehee on 9/30/24.
//

import SwiftUI
import WebKit

struct MusicDetailView: View {
    var url: String
    
    var body: some View {
        YouTubeWebView(url: url)
    }
}

struct YouTubeWebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<YouTubeWebView>) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}

#Preview {
    MusicDetailView(url: "https://www.youtube.com/")
}
