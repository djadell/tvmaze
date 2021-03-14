//
//  TvShowVM.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 14/03/2021.
//

import Foundation
import UIKit

struct TvShowViewModel {
    let name: String
    let rating: Float
    let summary: String
    
    
    init(tvShow: DBtvshow) {
        self.name = tvShow.name ?? "--"
        self.rating = tvShow.rating?.average ?? 0.0
        self.summary = tvShow.summary ?? ""
    }
    
}


