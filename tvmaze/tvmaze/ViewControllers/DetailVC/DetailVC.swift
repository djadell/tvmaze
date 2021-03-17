//
//  DetailVC.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 08/03/2021.
//

import UIKit

class DetailVC: UIViewController {

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
        title = tvShowViewModel?.name
        configUI()
    }

    func configUI() {
        self.titleLabel.text = tvShowViewModel?.name
        self.posterImageView.getImageWithUrl(urlString: tvShowViewModel?.image ?? "")
        self.ratingTitleLabel.text = "Ranking:"
        self.ratingLabel.text = tvShowViewModel?.rating.description
        if let tempValue = tvShowViewModel?.rating ?? 0.0 {
            progressValue = tempValue / 10
        }
        self.ratingProgressView.setProgress(progressValue, animated: true)
        
        print("ProgressV: \(progressValue) Rating: \(String(describing: tvShowViewModel?.rating.description))")
        print("Summary:\n\n\(String(describing: tvShowViewModel?.summary))")
    }
    
}
