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
    
    override init() {
        super.init()
        if !NetStatus.shared.isMonitoring {
            NetStatus.shared.startMonitoring()
            print("[DEBUG][\(String(describing: Service.self))] MonitorNetwork is Activated!")
        }
    }
    
    //MARK: - Public functions
    func fetchFirtsTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        if NetStatus.shared.isConnected {
            getTvShowsByPage(page: page, success: success, failure: failure)
        } else {
            print("[DEBUG][\(String(describing: Service.self))] No internet connection!")
        }
    }
    
    func fetchNextTvShows(success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)) {
        if NetStatus.shared.isConnected {
            page+=1
            getTvShowsByPage(page: page, success: success, failure: failure)
        } else {
            print("[DEBUG][\(String(describing: Service.self))] No internet connection!")
        }
    }
    
    func getImageWithUrl(urlString: String, success: (@escaping (UIImage) -> Void), failure: (@escaping (Error?)-> Void)) {
        if NetStatus.shared.isConnected {
            self.downloadImageWithUrl(urlString: urlString, success: success, failure: failure)
        } else {
            print("[DEBUG][\(String(describing: Service.self))] No internet connection!")
        }
    }
    
    //MARK: - Private functions
    fileprivate func downloadImageWithUrl(urlString: String, success: (@escaping (UIImage) -> Void), failure: (@escaping (Error?)-> Void)) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                print("[\(String(describing: Service.self))] Failed to get remote image", error)
                return
            }
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    success(image)
                }
            }
        }.resume()
    }
    
    fileprivate func getTvShowsByPage(page: Int, success: (@escaping ([DBtvshow]?) -> Void), failure: (@escaping (Error?)-> Void)){
        let urlString = baseURL+showsIndexURL+"?page=\(page)"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
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
                DispatchQueue.main.async {
                    failure(jsonError)
                }
                print("[\(String(describing: Service.self))] Failed to decode: ", jsonError)
            }
        }.resume()
    }
}
