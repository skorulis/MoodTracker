//  Created by Alexander Skorulis on 24/10/2022.

import SwiftUI
import ASKCore

struct ContentView: View {
    
    @Environment(\.factory) private var factory
    
    var body: some View {
        MoodHistoryView(viewModel: factory.resolve())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
