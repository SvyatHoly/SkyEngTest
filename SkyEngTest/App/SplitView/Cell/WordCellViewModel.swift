
import Foundation
import RxSwift

protocol WordCellViewModelInput {}
protocol WordCellViewModelOutput {
    var word: Observable<Word> { get }
}
protocol WordCellViewModelType {
    var input: WordCellViewModelInput { get }
    var output: WordCellViewModelOutput { get }
}

class WordCellViewModel: WordCellViewModelType,
                                WordCellViewModelInput,
                                WordCellViewModelOutput {

    // MARK: Input & Output
    var input: WordCellViewModelInput { return self }
    var output: WordCellViewModelOutput { return self }

    // MARK: Output
    let word: Observable<Word>

    // MARK: Init
    init(word: Word) {
        self.word = Observable.just(word)
    }
    
    deinit {
        Logger.info("WordCellViewModel deallocated")
    }
}
