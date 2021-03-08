//
//  DBtvshow.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import Foundation

// MARK: - Model
public struct DBtvshow: Decodable {
    private(set) var name: String?
    private(set) var rating: Float?
    private(set) var summary: String?
    enum rating {
        case average
    }
    enum image: String, Decodable {
        case medium, original
    }
}


