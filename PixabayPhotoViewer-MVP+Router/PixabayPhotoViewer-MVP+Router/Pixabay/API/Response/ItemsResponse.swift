//
//  ItemsResponse.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import Foundation

struct ItemsResponse<Item: Decodable>: Decodable {
    let hits: [Item]
    
    init(hits: [Item]) {
        self.hits = hits
    }
}
