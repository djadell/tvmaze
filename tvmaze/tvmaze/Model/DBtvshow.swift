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
    let image: Image?
    let summary: String?
}

struct Rating: Decodable {
    let average: Float?
}

struct Image: Decodable {
    let medium: String?
    let original: String?
}
