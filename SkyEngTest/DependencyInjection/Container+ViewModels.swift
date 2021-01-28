
import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerViewModels() {
        self.autoregister(SplitViewModel.self, initializer: SplitViewModel.init)
        self.autoregister(DetailsViewModel.self, initializer: DetailsViewModel.init)
    }
}
