//
//  LoadingTVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 17/03/2021.
//

import UIKit

class LoadingTVC: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        spinner.color = .systemBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
