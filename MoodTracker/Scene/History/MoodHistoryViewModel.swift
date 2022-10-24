//Created by Alexander Skorulis on 24/10/2022.

import Foundation

final class MoodHistoryViewModel: ObservableObject {
    
    @Published var showingNew: Bool = false
    
}

// MARK: - Logic

extension MoodHistoryViewModel {
    
    func addEntry() {
        showingNew = true
    }
    
}
