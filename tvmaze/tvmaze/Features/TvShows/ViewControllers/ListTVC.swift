//
//  ListTVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import UIKit

class ListTVC: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var tvShowViewModel: TvShowViewModel? {
        didSet {
            titleLabel.text = tvShowViewModel?.name
            posterImageView.getImageWithUrl(urlString: tvShowViewModel?.image ?? "")
        }
    }
}


