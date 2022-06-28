
import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [Photo]
}

struct Photo: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
}

enum URLKing: String {
    case raw
    case full
    case regular
    case small
    case thumb
}
