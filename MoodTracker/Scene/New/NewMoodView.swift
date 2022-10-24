//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import SwiftUI
import ASSwiftUI

// MARK: - Memory footprint

struct NewMoodView {
    
    @StateObject var viewModel: NewMoodViewModel
    @Environment(\.dismiss) private var dismiss
}

// MARK: - Rendering

extension NewMoodView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            nav
            ScrollView {
                fields
            }
        }
    }
    
    private var fields: some View {
        VStack {
            Text("Mood")
            Slider(value: $viewModel.moodLevel)
            Text("Progress")
            Slider(value: $viewModel.progress)
            
            emotionSelector
            TextField("Note", text: $viewModel.note)
                .textFieldStyle(.roundedBorder)
            
            TextField("Action", text: $viewModel.action)
                .textFieldStyle(.roundedBorder)
            
            Button(action: save) {
                Text("Save")
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var emotionSelector: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))],
                  spacing: 4
        ) {
            ForEach(Emotion.allCases) { emotion in
                emojiButton(emotion)
            }
        }
    }
    
    private func emojiButton(_ emotion: Emotion) -> some View {
        Button(action: {viewModel.toggle(emotion: emotion)} ) {
            VStack {
                Text(emotion.emoji)
                    .font(.largeTitle)
            }
            .padding(6)
                
        }
        .border(viewModel.emotions.contains(emotion) ? Color.black : Color.clear)
    }
    
    private var nav: some View {
        NavBar(left: EmptyView(),
               mid: BarButtonItem.title("New"),
               right: BarButtonItem.close(close))
    }
    
    func save() {
        viewModel.save()
        dismiss()
    }
    
    func close() {
        dismiss()
    }
}

// MARK: - Previews

struct NewMoodView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        NewMoodView(viewModel: ioc.resolve())
    }
}

