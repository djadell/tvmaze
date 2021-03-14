//
//  Service.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 14/03/2021.
//

import UIKit

class Service: NSObject {
    static let shared = Service()
    var page: Int = 1
    
    //MARK: - Public functions
    func fetchFirtsTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        getTvShowsByPage(page: page, success: success, failure: failure)
    }
    
    func fetchNextTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        page+=1
        getTvShowsByPage(page: page, success: success, failure: failure)
    }
    
    //MARK: - Private functions
    fileprivate func getTvShowsByPage(page: Int, success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)){
        let urlString = "https://api.tvmaze.com/shows?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                failure(error)
                print("[\(String(describing: Service.self))] Failed to fetch Firts TvShows:", error)
                return
            }
            //MARK: Check response
            guard let data = data else { return }
            do {
                let tvShows = try JSONDecoder().decode([DBtvshow].self, from: data)
                DispatchQueue.main.async {
                    success(tvShows)
                }
            } catch let jsonError {
                print("[\(String(describing: Service.self))] Failed to decode: ", jsonError)
            }
        }.resume()
    }
}
