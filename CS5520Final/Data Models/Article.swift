//
//  Article.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/6/23.
//

struct Article {
    var title: String
    var content: String
    var author: String
    var date: String
    var tags: [String]

    init(title: String, content: String, author: String, date: String, tags: [String]) {
        self.title = title
        self.content = content
        self.author = author
        self.date = date
        self.tags = tags
    }
}
