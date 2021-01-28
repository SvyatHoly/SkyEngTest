//
//  SkyEngTestTests.swift
//  SkyEngTestTests
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Quick
import Nimble
import Swinject
import RxNimble
import RxSwift

@testable import SkyEngTest


class SkyEngTestSpec: QuickSpec {
    struct StubNetwork: Networking {
        
        fileprivate static let json =
            "[" +
            "{" +
            "\"id\": 179210," +
            "\"text\":\"lo and behold\"," +
            "\"meanings: [" +
            "{" +
            "\"id\":255131," +
            "\"partOfSpeechCode\":\"exc\"," +
            "\"translation\":{" +
            "\"text\":\"\\u0441\\u043c\\u043e\\u0442\\u0440\\u0438-\\u043a\\u0430\\\"," +
            "\"note\":" +
            "}," +
            "\"previewUrl\":\"\\/\\/d2zkmv5t5kao9.cloudfront.net\\/images\\/9f4503e46441c9aab6f50819522b3577.jpeg?w=96&h=72\"," +
            "\"imageUrl\":\"\\/\\/d2zkmv5t5kao9.cloudfront.net\\/images\\/9f4503e46441c9aab6f50819522b3577.jpeg?w=640&h=480\"," +
            "\"transcription\":\"l\"," +
            "\"soundUrl\":\"\"" +
            "}" +
            "]" +
            "}" +
            "]"
        func wordsRequest(word: String) -> Observable<WordsEndpointResponse> {
            let data = StubNetwork.json.data(using: String.Encoding.utf8, allowLossyConversion: false)
            return Observable.just(try! WordsEndpointResponse(from: data!))
        }
        
    }
    
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
            
            // Registrations for the network using URLSession.
            container.register(Networking.self) { _ in Network() }
            container.register(SessionService.self) { r in
                SessionService(networkingClient: r.resolve(Networking.self)!)
            }
            
            // Registration for the stub network.
            container.register(Networking.self, name: "stub") { _ in StubNetwork() }
            container.register(SessionService.self, name: "stub") { r in
                SessionService(networkingClient: r.resolve(Networking.self, name: "stub")!)
            }
        }
        
        it("returns test word.") {
            let testWord = Word(text: "test",
                                translation: "экзамен",
                                imageURL: URL(string: "https://d2zkmv5t5kao9.cloudfront.net/images/7843b72892db15579912e5072bfb2754.jpeg?w=640&h=480"))
            let fetcher = container.resolve(SessionService.self)!
            let words = try! fetcher.getWords(word: "test").toBlocking().first()
            expect(words?.first).to(equal(testWord))
        }
    }
}
