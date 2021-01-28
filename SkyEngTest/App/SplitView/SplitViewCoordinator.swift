//
//  SplitViewCoordinator.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import RxSwift

final class SplitViewCoordinator: BaseCoordinator {
    
    private let splitViewModel: SplitViewModel
    
    private let disposeBag = DisposeBag()
    
    init(splitViewModel: SplitViewModel) {
        self.splitViewModel = splitViewModel
    }
    
    deinit {
        Logger.info("SplitViewCoordinator dellocated")
    }
    
    override func start() {
        var viewController = SplitViewController()
        
        self.navigationController.viewControllers = [viewController]
        
        viewController.bind(to: splitViewModel)
        setUpBindings()
    }
    
    private func setUpBindings() {
        splitViewModel.presentDetails.bind(onNext: {  [weak self] word in
            self?.presentDetails()
        })
            .disposed(by: disposeBag)
    }
    
    
    private func presentDetails() {
        Logger.info("Presenting details")
        
        let coordinator = AppDelegate.container.resolve(DetailsViewCoordinator.self)!
        coordinator.navigationController = self.navigationController
        coordinator.parentViewModel = self.splitViewModel

        self.start(coordinator: coordinator)
    }
}
