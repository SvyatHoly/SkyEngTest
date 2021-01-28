
import Foundation

// MARK: - WordEndpointModelElement
struct WordEndpointModelElement: Codable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}

// MARK: - Meaning
struct Meaning: Codable {
    let id: Int
    let partOfSpeechCode: String
    let translation: Translation
    let previewURL, imageURL, transcription, soundURL: String

    enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

// MARK: - Translation
struct Translation: Codable {
    let text: String
    let note: String?
}

typealias WordEndpointModel = [WordEndpointModelElement]


struct WordsEndpointResponse: Decodable {
    var words = [Word]()
    
    init(from data: Data) throws {
        let response = try JSONDecoder().decode(WordEndpointModel.self, from: data)
        for item in response {
            let text = item.text
            
            var meaningImage: URL?
            if let imageUrl = item.meanings.first?.imageURL {
                meaningImage = URL(string: "https:\(imageUrl)")
            }
            
            let translation = item.meanings.first?.translation.text
            
            if (translation != nil) {
                let word = Word(text: text, translation: translation!, imageURL: meaningImage)
                self.words.append(word)
            }
        }
    }
}
