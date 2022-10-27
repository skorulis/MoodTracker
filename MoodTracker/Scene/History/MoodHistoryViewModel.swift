//Created by Alexander Skorulis on 24/10/2022.

import ASKCore
import Foundation

final class MoodHistoryViewModel: CoordinatedViewModel, ObservableObject {
    
}

// MARK: - Logic

extension MoodHistoryViewModel {
    
    func addEntry() {
        coordinator.present(MoodPath.new, style: .sheet)
    }
    
}
