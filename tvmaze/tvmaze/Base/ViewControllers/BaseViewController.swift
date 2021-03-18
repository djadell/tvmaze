//
//  BaseViewController.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 18/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAler(title: String?, message: String?) {
        showAlert(title: title, message: title, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
    
    func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style? = .alert, actions: [UIAlertAction]?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle ?? .alert)
            if let actions = actions {
                for action in actions {
                    alert.addAction(action)
                }
            self.present(alert, animated: true)
        }
    }
    
}
