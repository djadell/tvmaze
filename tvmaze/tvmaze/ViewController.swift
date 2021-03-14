//
//  ViewController.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 07/03/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //FIXME: temporally testing dev
        Service.shared.fetchFirtsTvShows { (tvShows) in
            //refresh table view
            print("[DEBUG] data:",tvShows ?? [])
        } failure: { (error) in
            if let error = error {
                print("Failed to get tvshows:", error)
                //show alert
                return
            }
        }
    }


}

