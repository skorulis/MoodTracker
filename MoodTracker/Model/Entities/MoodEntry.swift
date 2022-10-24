//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import CoreData

@objc(MoodEntry)
public class MoodEntry: NSManagedObject, Identifiable {
 
    @nonobjc class func fetch() -> NSFetchRequest<MoodEntry> {
        return NSFetchRequest<MoodEntry>(entityName: "MoodEntry")
    }
    
    @NSManaged public var date: Date
    @NSManaged public var moodLevel: Double
    
    @NSManaged public var action: String?
    @NSManaged public var criticism: String?
    @NSManaged public var emotionData: Data?
    @NSManaged public var note: String?
    @NSManaged public var progress: Double
    
    var emotions: [Emotion]? {
        get {
            guard let emotionData else { return nil }
            return try! JSONDecoder().decode([Emotion].self, from: emotionData)
        }
        set {
            guard let newValue else {
                emotionData = nil
                return
            }
            emotionData = try! JSONEncoder().encode(newValue)
        }
    }
    
    var emojiString: String? {
        guard let emotions = emotions, !emotions.isEmpty else {
            return nil
        }
        return emotions.map { $0.emoji }.joined(separator: " ")
    }
    
    var moodInt: Int {
        return Int(round(moodLevel * 10) - 5)
    }
}
