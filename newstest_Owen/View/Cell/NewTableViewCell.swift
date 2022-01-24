//
//  NewTableViewCell.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//

import UIKit
import Kingfisher

final class NewTableViewCell: UITableViewCell {
    @IBOutlet weak private var newsImageView: UIImageView!
    @IBOutlet weak private var newsContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setCell(_ data: ArticleModel) {
        newsImageView.kf.indicatorType = .activity
        if let urlStr = data.urlToImage, !urlStr.isEmpty {
            newsImageView.kf.setImage(with: URL(string: urlStr))
        } else {
            newsImageView.image = UIImage(named: "error_CloudIcon")
        }
        newsContentLabel.text = data.content ?? "No info"
    }
    
}
