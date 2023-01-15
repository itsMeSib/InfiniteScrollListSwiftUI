//
//  Model.swift
//  InfiniteScrolling
//
//  Created by Shahzaib Iqbal Bhatti  on 14/01/2023.
//

import Foundation

struct ImageModel: Hashable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
    let displayHeight: CGFloat = CGFloat.random(in: 100 ... 400)
    var isFavorite: Bool = false

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        url = try container.decode(String.self, forKey: .url)
        download_url = try container.decode(String.self, forKey: .download_url)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }

    init(id: String, author: String, width: Int, height: Int, url: String, download_url: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.download_url = download_url
    }
}
