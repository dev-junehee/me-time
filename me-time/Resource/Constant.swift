//
//  Constant.swift
//  me-time
//
//  Created by junehee on 9/17/24.
//

import Foundation

enum Constant {
    
    enum TodayEmotion {
        
        enum Positive: String, CaseIterable {
            case fresh = "상쾌해요"
            case excite = "흥겨워요"
            case funny = "재밌어요"
            case proud = "뿌듯해요"
            case thrilled = "설레어요"
            case refresh = "개운해요"
            case calm = "평온해요"
            case anticipate = "기대돼요"
            case happy = "행복해요"
            case grateful = "감사해요"
            case confident = "자신있어요"
            case satisfied = "만족해요"
            case relieved = "안도해요"
            case serene = "차분해요"
        }
        
        enum Negative: String, CaseIterable {
            case depressed = "우울해요"
            case sorrowful = "서러워요"
            case miserable = "비참해요"
            case intimidated = "위축돼요"
            case complex = "착잡해요"
            case unpleasant = "불쾌해요"
            case afraid = "두려워요"
            case lethargic = "무기력해요"
            case anxious = "불안해요"
            case worried = "걱정돼요"
            case annoyed = "거슬려요"
            case lonely = "외로워요"
            case discouraged = "낙심해요"
            case exhausted = "지쳤어요"
        }
        
        enum AllEmotions: String, CaseIterable {
            case fresh = "상쾌해요"
            case excite = "흥겨워요"
            case funny = "재밌어요"
            case proud = "뿌듯해요"
            case thrilled = "설레어요"
            case refresh = "개운해요"
            case calm = "평온해요"
            case anticipate = "기대돼요"
            case happy = "행복해요"
            case grateful = "감사해요"
            case confident = "자신있어요"
            case satisfied = "만족해요"
            case relieved = "안도해요"
            case serene = "차분해요"
            case depressed = "우울해요"
            case sorrowful = "서러워요"
            case miserable = "비참해요"
            case intimidated = "위축돼요"
            case complex = "착잡해요"
            case unpleasant = "불쾌해요"
            case afraid = "두려워요"
            case lethargic = "무기력해요"
            case anxious = "불안해요"
            case worried = "걱정돼요"
            case annoyed = "거슬려요"
            case lonely = "외로워요"
            case discouraged = "낙심해요"
            case exhausted = "지쳤어요"
        }
    }
    
    enum MorningPaper {
        static let contentPlaceholder = "지금 느끼고 있는 생각과 감정을 최대한 수정과 필터링을 거치지 않고, 있는 그대로 기록해 보세요. 훗날 오늘의 기록을 돌아봤을 때 그 때의 나를 떠올릴 수 있도록 사고의 흐름을 해치지 않고 여과없이 기록하는 것을 추천해요"
    }
    
}
