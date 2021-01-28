import Foundation
import RxSwift

// MARK: - Protocols
protocol Networking {
    func wordsRequest(word: String) -> Observable<WordsEndpointResponse>
}

// MARK: - Constants
internal let wordsEndpointURL = "https://dictionary.skyeng.ru/api/public/v1/words/search?search={word}"

// MARK: - Networking
final class Network: Networking {
    
    // MARK: - New Releases
    func wordsRequest(word: String) -> Observable<WordsEndpointResponse> {
        
        return Observable<WordsEndpointResponse>.create { observer in
            let wordsString = wordsEndpointURL.replacingOccurrences(of: "{word}", with: word.alphabetic)
            let wordsURL = URL(string: wordsString)!
            
            let urlRequest = URLRequest(url: wordsURL)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                do {
                    let tracksResponse = try WordsEndpointResponse(from: data ?? Data())
                    observer.onNext(tracksResponse)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
