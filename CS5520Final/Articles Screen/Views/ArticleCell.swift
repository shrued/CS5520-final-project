//
//  ArticleCell.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/6/23.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let reuseIdentifier = "ArticleCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    private let tagsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(authorLabel)
        addSubview(dateLabel)
        addSubview(tagsView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            dateLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            tagsView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            tagsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tagsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tagsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }

    func configure(with article: Article) {
        titleLabel.text = article.title
        contentLabel.text = article.content
        authorLabel.text = "Author: \(article.author)"
        dateLabel.text = article.date

        displayTags(article.tags)
    }

    private func displayTags(_ tags: [String]) {
        for tagText in tags {
            let tagLabel = UILabel()
            tagLabel.text = tagText
            tagLabel.font = UIFont.systemFont(ofSize: 14)
            tagLabel.textColor = .white
            tagLabel.backgroundColor = UIColor.orange
            tagLabel.layer.cornerRadius = 5
            tagLabel.clipsToBounds = true

            let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            tagLabel.text = tagText
            tagLabel.sizeToFit()
            tagLabel.frame = tagLabel.frame.inset(by: padding)

            tagLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

            tagsView.addArrangedSubview(tagLabel)
        }
    }
}
