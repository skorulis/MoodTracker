//Created by Alexander Skorulis on 24/10/2022.

import Foundation
import SwiftUI
import ASSwiftUI
import StarRatingViewSwiftUI

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
            HStack {
                Text("Mood")
                MoodIndicator(value: viewModel.moodLevel)
                    .frame(width: 80, height: 80)
            }
            
            Slider(value: $viewModel.moodLevel)
            Text("Progress")
            StarRatingView(rating: $viewModel.progress, maxRating: 5)
                .frame(height: 40)
            
            emotionSelector
            textFields
            
            DatePicker("Time", selection: $viewModel.date)
            
            Button(action: save) {
                Text("Save")
            }
            Spacer()
                .frame(height: 20)
        }
        .padding(.horizontal, 16)
    }
    
    private var textFields: some View {
        VStack {
            TextField("Note", text: $viewModel.note)
                .textFieldStyle(.roundedBorder)
            
            TextField("Action", text: $viewModel.action)
                .textFieldStyle(.roundedBorder)
            
            TextField("Physical", text: $viewModel.physical)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    private var emotionSelector: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))],
                  spacing: 8
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
                
                Text(emotion.rawValue)
                    .fixedSize()
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

