//Created by Alexander Skorulis on 24/10/2022.

import Foundation

final class NewMoodViewModel: ObservableObject {
    
    private let store: CoreDataStore
    private let existing: MoodEntry?
    
    @Published var date: Date
    @Published var moodLevel: Double = 0.5
    @Published var progress: Float = 0
    @Published var emotions: Set<Emotion> = []
    @Published var note: String = ""
    @Published var action: String = ""
    @Published var physical: String = ""
    
    init(store: CoreDataStore, argument: Argument) {
        self.existing = argument.existing
        self.moodLevel = existing?.moodLevel ?? 0.5
        self.progress = Float(existing?.progress ?? 0)
        self.emotions = Set(existing?.emotions ?? [])
        self.note = existing?.note ?? ""
        self.action = existing?.action ?? ""
        self.physical = existing?.physical ?? ""
        self.date = existing?.date ?? Date()
        
        self.store = store
    }
    
}

extension NewMoodViewModel {
    struct Argument {
        let existing: MoodEntry?
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
        let entry = existing ?? MoodEntry(context: store.mainContext)
        entry.date = date
        entry.moodLevel = moodLevel
        entry.progress = Double(progress / 5)
        entry.revisionID = UUID().uuidString
        
        if !note.isEmpty {
            entry.note = note
        }
        if !action.isEmpty {
            entry.action = action
        }
        if !physical.isEmpty {
            entry.physical = physical
        }
        
        if !emotions.isEmpty {
            entry.emotions = Array(emotions)
        }
        
        
        try! store.mainContext.save()
    }
    
}
