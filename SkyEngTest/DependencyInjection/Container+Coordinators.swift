
import Swinject

extension Container {
    
    func registerCoordinators() {
        self.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        self.autoregister(SplitViewCoordinator.self, initializer: SplitViewCoordinator.init)
        self.autoregister(DetailsViewCoordinator.self, initializer: DetailsViewCoordinator.init)

    }
    
}
