//  Created by Alexander Skorulis on 24/10/2022.

import SwiftUI
import ASKCore

@main
struct MoodTrackerApp: App {
    
    private let ioc = IOC(purpose: .normal)
    private let errorPresenter: ErrorPresentationManager
    
    init() {
        self.errorPresenter = ioc.resolve()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.factory, ioc)
                .environment(\.managedObjectContext, ioc.resolve(CoreDataStore.self).mainContext)
        }
    }
}
