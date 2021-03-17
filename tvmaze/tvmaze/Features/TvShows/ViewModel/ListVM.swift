//
//  ListVM.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 17/03/2021.
//

import Foundation

class ListVM: NSObject {
    static let shared = ListVM()
    
    //MARK: - Public data functions
    func fetchFirtsTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        Service.shared.fetchFirtsTvShows(success: success, failure: failure)
    }
    
    func fetchNextTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        Service.shared.fetchNextTvShows(success: success, failure: failure)
    }
}
