
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        self.autoregister(SessionService.self, initializer: SessionService.init).inObjectScope(.container)
        self.autoregister(Networking.self, initializer: Network.init).inObjectScope(.container)
    }
}
