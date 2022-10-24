//  Created by Alexander Skorulis on 24/10/2022.

import ASKCore
import Foundation
import SwinjectAutoregistration

public final class IOC: IOCService {
    
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerServices()
        registerViewModels()
        registerStores()
        
        
    }
    
    private func registerServices() {
        
    }
    
    private func registerViewModels() {
        container.autoregister(MoodHistoryViewModel.self, initializer: MoodHistoryViewModel.init)
        container.autoregister(NewMoodViewModel.self, initializer: NewMoodViewModel.init)
    }
    
    private func registerStores() {
        switch purpose {
        case .testing:
            container.autoregister(CoreDataStore.self, initializer: CoreDataStore.previews)
                .inObjectScope(.container)
        case .normal:
            container.autoregister(CoreDataStore.self, initializer: CoreDataStore.database)
                .inObjectScope(.container)
        }
    }
    
}
