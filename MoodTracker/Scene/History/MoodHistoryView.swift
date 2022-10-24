//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct MoodHistoryView {
    
    @StateObject var viewModel: MoodHistoryViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\MoodEntry.date, order: .reverse)]) var history: FetchedResults<MoodEntry>
    @Environment(\.factory) private var factory
}

// MARK: - Rendering

extension MoodHistoryView: View {
    
    var body: some View {
        content
            .sheet(isPresented: $viewModel.showingNew) {
                NewMoodView(viewModel: factory.resolve())
            }
    }
    
    private var content: some View {
        VStack {
            nav
            List {
                ForEach(history) { moodEntry in
                    MoodHistoryCell(entry: moodEntry)
                }
            }
            .listStyle(.plain)
        }
    }
    
    private var nav: some View {
        NavBar(left: EmptyView(),
               mid: BarButtonItem.title("History"),
               right: BarButtonItem.iconButton(Image(systemName: "plus.circle.fill"), viewModel.addEntry))
    }
}

// MARK: - Previews

struct MoodHistoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MoodHistoryView(viewModel: ioc.resolve())
    }
}

