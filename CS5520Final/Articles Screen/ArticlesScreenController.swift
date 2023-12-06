//
//  ArticlesScreenController.swift
//  CS5520Final
//
//  Created by Shruti Saravanan on 12/6/23.
//

import UIKit
import Firebase

class ArticlesScreenController: UIViewController {

    let articlesView = ArticlesScreenView()
    var articles: [Article] = []
    let database = Firestore.firestore()

    override func loadView() {
        view = articlesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Useful Articles and blogs"

        articlesView.tableView.delegate = self
        articlesView.tableView.dataSource = self
        articlesView.tableView.estimatedRowHeight = 100
        articlesView.tableView.rowHeight = UITableView.automaticDimension

        articlesView.tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)

        fetchArticles()
    }

    private func fetchArticles() {
        let articlesQuery = database.collection("articles")

        articlesQuery.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching articles: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No articles found")
                return
            }

            self.articles = self.parseArticles(from: documents)
            self.articlesView.tableView.reloadData()
        }
    }

    private func parseArticles(from documents: [QueryDocumentSnapshot]) -> [Article] {
        var articles: [Article] = []

        for document in documents {
            if let articleData = document.data() as? [String: Any],
                let title = articleData["title"] as? String,
                let content = articleData["content"] as? String,
                let author = articleData["author"] as? String,
                let date = articleData["date"] as? String {
                let article = Article(title: title, content: content, author: author, date: date)
                articles.append(article)
            }
        }

        return articles
    }
}

extension ArticlesScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
}
