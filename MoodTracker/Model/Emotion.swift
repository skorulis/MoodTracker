//Created by Alexander Skorulis on 24/10/2022.

import Foundation

enum Emotion: String, CaseIterable, Codable, Identifiable {
    
    case `lazy`
    case tired
    case happy
    case energised
    case sad
    case angry
    case frustrated
    
    var emoji: String {
        switch self {
        case .lazy: return "😫"
        case .tired: return "😴"
        case .happy: return "😊"
        case .energised: return "⚡"
        case .sad:  return "😔"
        case .angry: return "😡"
        case .frustrated: return "😠"
        }
    }
    
    var id: String { rawValue }
    
}
