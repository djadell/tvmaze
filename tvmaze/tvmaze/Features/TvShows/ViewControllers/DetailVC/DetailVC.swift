//
//  DetailVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import UIKit

class DetailVC: BaseViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingProgressView: UIProgressView!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var tvShowViewModel: TvShowViewModel?
    fileprivate var progressValue:Float = 0.0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI() {
        ///Title
        title = tvShowViewModel?.name
        self.titleLabel.text = "Lang: \(tvShowViewModel?.language ?? "")"
        ///Poster image
        self.posterImageView.getImageWithUrl(urlString: tvShowViewModel?.image ?? "")
        ///Rating
        self.ratingTitleLabel.text = "Ranking:"
        self.ratingLabel.text = tvShowViewModel?.rating.description
        ///Rating value
        if let tempValue = tvShowViewModel?.rating ?? 0.0 {
            progressValue = tempValue / 10
        }
        self.ratingProgressView.setProgress(progressValue, animated: true)
        ///Summary
        self.summaryTextView.attributedText = tvShowViewModel?.summary.htmlToAttributedString
    }
    
}
