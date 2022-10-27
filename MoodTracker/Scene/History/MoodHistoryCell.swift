//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import StarRatingViewSwiftUI
import SwiftUI

// MARK: - Memory footprint

struct MoodHistoryCell {
    let entry: MoodEntry
    
    static private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
}

// MARK: - Rendering

extension MoodHistoryCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                MoodIndicator(value: entry.moodLevel)
                    .frame(width: 40)
                Text(dateString)
            }
            
            
            if entry.progress > 0 {
                StarRatingView(rating: Float(entry.progress * 5), maxRating: 5)
                    .frame(height: 40)
            }
            if let text = entry.emojiString {
                Text("Emotions: \(text)")
            }
            if let action = entry.action {
                Text("Action: \(action)")
            }
            if let physical = entry.physical {
                Text("Physical: \(physical)")
            }
            if let note = entry.note {
                Text(note)
            }
        }
    }
    
    var dateString: String {
        return Self.dateFormatter.string(from: entry.date)
    }
}

