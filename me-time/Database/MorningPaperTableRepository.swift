//
//  MorningPaperTableRepository.swift
//  me-time
//
//  Created by junehee on 9/18/24.
//

import Foundation
import RealmSwift

final class MorningPaperTableRepository {
    
    private let realm = try! Realm()

    // 전체 삭제
    func deleteAllMorningPaper() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Realm Error: ", error)
        }
    }
    
    // 파일 경로 가져오기
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "No Realm fileURL")
    }

    // 스키마 버전 확인하기
    func getschemaVersion() {
        print(realm.configuration.schemaVersion)
    }
    
}
