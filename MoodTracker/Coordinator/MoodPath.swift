//Created by Alexander Skorulis on 27/10/2022.

import ASKCore
import Foundation
import SwiftUI

enum MoodPath: BoundCoordinatorPath, Hashable, Identifiable {
    
    case list
    case new
    case edit(_ entry: MoodEntry)
    
    @ViewBuilder
    func render(coordinator: StandardCoordinator) -> some View {
        switch self {
        case .list:
            MoodHistoryView(viewModel: coordinator.resolve())
        case .new:
            NewMoodView(viewModel: coordinator.resolve(NewMoodViewModel.self, argument: NewMoodViewModel.Argument(existing: nil)))
        case .edit(let entry):
            NewMoodView(viewModel: coordinator.resolve(NewMoodViewModel.self, argument: NewMoodViewModel.Argument(existing: entry)))
        }
    }
    
    var id: String {
        return String(describing: self)
    }
}
