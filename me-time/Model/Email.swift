//
//  Email.swift
//  me-time
//
//  Created by junehee on 9/30/24.
//

import SwiftUI

/**
 address 개발자 이메일
 subject 메일 제목
 body 메일 본문
 */
struct Email {
    let address: String
    let subject: String
    var body: String {"""
    보내주신 피드백은 더 나은 서비스 개발을 위해 활용됩니다! :)
    """
    }
    
    func sendEmail(openURL: OpenURLAction) {
        let urlString = "mailto:\(address)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        guard let URL = URL(string: urlString) else { return }
        openURL(URL) { accepted in
            if !accepted {
                print("ERROR: 현재 기기는 이메일을 지원하지 않습니다.")
            }
        }
    }
}
