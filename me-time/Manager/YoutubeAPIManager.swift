//
//  NetworkManager.swift
//  me-time
//
//  Created by junehee on 9/30/24.
//

import Foundation

class YoutubeAPIManager {
    
    static let shared = YoutubeAPIManager()
    private init() { }

    func searchMusic(_ query: String, completion: @escaping (Result<[YouTubeSearchItems], Error>) -> Void) {
        
        /// "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=react&type=video&key=받은키복사"
        
        let urlString = API.BASE_URL + "part=snippet&maxResults=10&q=\(query)&type=video&key=\(API.KEY)"
        
        guard let URL = URL(string: urlString) else { return }
        let request = URLRequest(url: URL, timeoutInterval: 5)
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // print("DATA ✨✨✨", data)
            // print("Response 🍀🍀🍀", response)
            // print("error 🚨🚨🚨", error)
            
            // 에러가 존재한다면, 문제가 있는 상황. 실제 데이터는 없음
            if let error = error {
                completion(.failure(error))
                print("에러났어용")
                return
            }
            
            // 에러가 nil이라는 건 성공했다는 가능성이 있음
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                print("성공했지만 데이터 없어용")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YouTubeSearch.self, from: data)
                if !result.items.isEmpty {
                    completion(.success(result.items))
                } else { return }
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
