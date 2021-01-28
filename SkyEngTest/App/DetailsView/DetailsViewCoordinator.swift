//
//  DetailsViewCoordinator.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import UIKit
import RxSwift

final class DetailsViewCoordinator: BaseCoordinator {
    
    var detailsViewController: BaseNavigationController!
    weak var parentViewModel: SplitViewModel!
    
    private let viewModel: DetailsViewModel
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    deinit {
        Logger.info("DetailsViewCoordinator dellocated")
    }
    
    override func start() {
        var viewController = DetailsViewController()
        viewController.bind(to: self.viewModel)
        
        detailsViewController = BaseNavigationController(rootViewController: viewController)
        detailsViewController.navigationBar.isHidden = true
        
        self.navigationController.presentOnTop(detailsViewController, animated: true)
        
        viewModel.input.dismissed
            .bind(to: parentViewModel.childDismissed)
            .disposed(by: disposeBag)
        
        parentViewModel.presentDetails
            .bind(to: viewModel.output.word)
            .disposed(by: disposeBag)
    }
}
