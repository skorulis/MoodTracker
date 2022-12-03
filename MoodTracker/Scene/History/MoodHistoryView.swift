//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import SwiftUI
import ASKDesignSystem

// MARK: - Memory footprint

struct MoodHistoryView {
    
    @StateObject var viewModel: MoodHistoryViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\MoodEntry.date, order: .reverse)]) var history: FetchedResults<MoodEntry>
    @Environment(\.factory) private var factory
}

// MARK: - Rendering

extension MoodHistoryView: View {
    
    var body: some View {
        ListTemplate(nav: nav, content: content)
    }
    
    private func content() -> some View {
        ForEach(history) { moodEntry in
            Button(action: { viewModel.select(moodEntry) }) {
                MoodHistoryCell(entry: moodEntry)
            }
            .id(moodEntry.revisionID)
        }
    }
    
    private func nav() -> some View {
        NavBar(mid: .title("History"),
               right: .iconButton(Image(systemName: "plus.circle.fill"), viewModel.addEntry))
    }
}

// MARK: - Previews

struct MoodHistoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MoodHistoryView(viewModel: ioc.resolve())
    }
}

