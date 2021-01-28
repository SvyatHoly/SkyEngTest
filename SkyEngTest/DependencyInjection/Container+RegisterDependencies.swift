
import Swinject

extension Container {
    func registerDependencies() {
        self.registerServices()
        self.registerViewModels()
        self.registerCoordinators()
    }
}
