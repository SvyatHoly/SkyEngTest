
import Foundation
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    var window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        self.showDashboard()
    }
    
    //MARK: Helper methods

    private func showDashboard() {
        self.removeChildCoordinators()
        
        let coordinator = AppDelegate.container.resolve(SplitViewCoordinator.self)!
        coordinator.navigationController = BaseNavigationController()
        self.start(coordinator: coordinator)
        
        ViewControllerUtils.setRootViewController(
            window: self.window,
            viewController: coordinator.navigationController,
            withAnimation: true)
    }

}
