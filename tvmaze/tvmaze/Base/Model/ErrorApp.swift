//
//  ErrorApp.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 18/03/2021.
//

import Foundation

enum ErrorApp: Error {
    case noInternetConection
    case apiError
    case downloadImage
    case other
}

extension ErrorApp: LocalizedError {
    public var localizedDescription: String? {
            switch self {
            case .noInternetConection:
                return NSLocalizedString("Description of no internet connection", comment: "No internet connection")
            case .apiError:
                return NSLocalizedString("Description of API error", comment: "Can not connect to server")
            case .downloadImage:
                return NSLocalizedString("Description of downloading image error", comment: "Image could not be downloaded")
            case .other:
                return NSLocalizedString("Description of generic error", comment: "Unknown error")
            }
        }
}
