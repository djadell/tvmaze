//
//  DBtvshow.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import Foundation

// MARK: - Model
struct DBtvshow: Decodable {
    let id: Int?
    let url: String?
    let name: String?
    let rating: Rating?
    enum image: String, Decodable {
        case medium, original
    }
    let summary: String?
}

struct Rating: Decodable {
    let average: Float?
}

