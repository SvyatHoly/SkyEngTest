//
//  SplitViewModel.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplitViewModelInput {
    var childDismissed: PublishSubject<Void> { get }
    func wordSelected(from viewController: (UIViewController), word: Word)
    func textFieldPromted(from viewController: (UIViewController), text: String)
    var presentDetails: BehaviorRelay<Word> { get }

}

protocol SplitViewModelOutput {
    var wordCellsModelType: Observable<[WordCellViewModelType]> { get }
}

protocol SplitViewModelType {
    var input: SplitViewModelInput { get }
    var output: SplitViewModelOutput { get }
}

final class SplitViewModel: SplitViewModelType, SplitViewModelInput, SplitViewModelOutput {
    
    // MARK: Inputs & Outputs
    var input: SplitViewModelInput { return self }
    var output: SplitViewModelOutput { return self }
    
    // MARK: - Properties
    // MARK: Dependencies
    private let sessionService: SessionService
    
    // MARK: Inputs
    func wordSelected(from viewController: (UIViewController), word: Word) {
        print(word)
        self.presentDetails.accept(word)
        // TODO
    }
    
    func textFieldPromted(from viewController: (UIViewController), text: String) {
        if text.isEmpty {
            wordCollections.accept([])
            return
        }
        _ = self.sessionService.getWords(word: text).subscribe(onNext: { [weak self] words in
            self?.wordCollections.accept(words)
        })
    }
    
    let presentDetails = BehaviorRelay<Word>(value: Word(text: "", translation: "", imageURL: nil))
    
    var childDismissed = PublishSubject<Void>()
    
    // MARK: Outputs
    lazy var wordCellsModelType: Observable<[WordCellViewModelType]> = {
        return wordCollections.mapMany { WordCellViewModel(word: $0) }
    }()

    // MARK: Private
    private let wordCollections = BehaviorRelay(value: [Word]())
    
    // MARK: - Initialization
    init(sessionService: SessionService) {
        self.sessionService = sessionService
    }
    
    deinit {
        Logger.info("SplitViewModel dellocated")
    }
    
}
