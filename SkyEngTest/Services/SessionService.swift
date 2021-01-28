
import Foundation
import RxSwift
import RxCocoa

protocol SessionSeriveProtocol {
    func getWords(word: String) -> Observable<[Word]>
}

class SessionService: SessionSeriveProtocol {
    
    // MARK: - Properties
    // MARK: Dependencies
    private let networkingClient: Networking
    
    // MARK: Private fields
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(networkingClient: Networking) {
        self.networkingClient = networkingClient
    }
    
    func getWords(word: String) -> Observable<[Word]> {
        return networkingClient.wordsRequest(word: word)
            .flatMap { response -> Observable<[Word]> in
                let words = response.words
                return Observable.just(words)
            }
    }
    
}
