//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MoodHistoryCell {
    let entry: MoodEntry
}

// MARK: - Rendering

extension MoodHistoryCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mood: \(entry.moodInt)")
            if entry.progress > 0 {
                Text("Progress: \(entry.progress)")
            }
            if let text = entry.emojiString {
                Text("Emotions: \(text)")
            }
            if let action = entry.action {
                Text("Action: \(action)")
            }
            if let note = entry.note {
                Text(note)
            }
        }
    }
}

