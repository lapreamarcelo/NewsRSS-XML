//
//  NewsCell.swift
//  News
//
//  Created by Marcelo on 25/7/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.newsDescription
        
        setupImage(url: news.imageURL)
        setupDate(date: news.publicationDate)
    }
    
    private func setupImage(url: String?) {
        guard let url = url, let imageURL = URL(string: url) else {
            return
        }
        
        newsImage.kf.setImage(with: imageURL)
    }
    
    private func setupDate(date: String?) {
        guard let date = date else {
            return
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let newsDate = dateFormatterGet.date(from: date) {
            dateLabel.text = dateFormatter.string(from: newsDate)
        }
    }
    
}
