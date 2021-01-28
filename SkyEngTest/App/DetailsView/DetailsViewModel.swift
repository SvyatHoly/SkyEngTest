//
//  DetailsViewModel.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailsViewModelInput {
    /// Call when view controller is dismissed
    var dismissed: PublishSubject<Void> { get }
}

protocol DetailsViewModelOutput {
    var word: BehaviorRelay<Word>! { get }
}

protocol DetailsViewModelType {
    var input: DetailsViewModelInput { get }
    var output: DetailsViewModelOutput { get }
}

final class DetailsViewModel: DetailsViewModelType,
                              DetailsViewModelInput,
                              DetailsViewModelOutput {
    // MARK: Inputs & Outputs
    var input: DetailsViewModelInput { return self }
    var output: DetailsViewModelOutput { return self }
    
    // MARK: Inputs
    let dismissed = PublishSubject<Void>()
    
    // MARK: Outputs
    var word: BehaviorRelay<Word>!
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Init
    init() {
        // Initializing utputs
        self.word = BehaviorRelay(value: Word(text: "text", translation: "translation", imageURL: nil))
    }
    
    deinit {
        Logger.info("DetailsViewModel dellocated")
    }
}
