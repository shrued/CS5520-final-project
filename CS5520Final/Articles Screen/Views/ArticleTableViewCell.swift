//
//  ArticleTableViewCell.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/6/23.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    func configure(with article: Article) {
        textLabel?.text = article.title
        detailTextLabel?.text = article.author
    }
}
