//
//  ListViewCell.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var tvShowViewModel: TvShowViewModel? {
        didSet {
            titleLabel.text = tvShowViewModel?.name
            posterImageView.getImageWithUrl(urlString: tvShowViewModel?.image ?? "")
        }
    }
    
    func config(title:String? = "--") {
        titleLabel.text = title
    }
    
}


