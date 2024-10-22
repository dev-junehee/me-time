//
//  UserDefaultsManager.swift
//  me-time
//
//  Created by junehee on 9/16/24.
//

import Foundation

enum UserDefaultsKey: String {
    case isUser
    case userID
    case nick
    case todayEmotion
}

struct UserDefaultsManager {
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    static var isUser: Bool
    
    @UserDefaultsWrapper (key: .userID, defaultValue: "InvalidUserID")
    static var userID: String
    
    @UserDefaultsWrapper (key: .nick, defaultValue: "Stranger")
    static var nick: String
    
    @UserDefaultsWrapper (key: .todayEmotion, defaultValue: "None")
    static var todayEmotion: String
    
    static func deleteUserDefaults(forKey: UserDefaultsKey) {
        switch forKey {
        case .isUser:
            _isUser.delete()
        case .userID:
            _userID.delete()
        case .nick:
            _nick.delete()
        case .todayEmotion:
            _todayEmotion.delete()
        }
    }
    
    static func deleteAll() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
