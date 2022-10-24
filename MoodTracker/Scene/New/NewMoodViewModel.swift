//Created by Alexander Skorulis on 24/10/2022.

import Foundation

final class NewMoodViewModel: ObservableObject {
    
    private let store: CoreDataStore
    
    @Published var moodLevel: Double = 0.5
    @Published var progress: Double = 0
    @Published var emotions: Set<Emotion> = []
    @Published var note: String = ""
    @Published var action: String = ""
    
    init(store: CoreDataStore) {
        self.store = store
    }
    
}

// MARK: - Logic

extension NewMoodViewModel {
    
    func toggle(emotion: Emotion) {
        if emotions.contains(emotion) {
            emotions.remove(emotion)
        } else {
            emotions.insert(emotion)
        }
    }
    
    func save() {
        let entry = MoodEntry(context: store.mainContext)
        entry.date = Date()
        entry.moodLevel = moodLevel
        entry.progress = progress
        
        if !note.isEmpty {
            entry.note = note
        }
        if !action.isEmpty {
            entry.action = action
        }
        
        if !emotions.isEmpty {
            entry.emotions = Array(emotions)
        }
        
        try! store.mainContext.save()
    }
    
}
