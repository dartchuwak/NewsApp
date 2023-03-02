//
//  ViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import SDWebImage
import SnapKit

final class NewsViewController: UIViewController {
    
    
    let newsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let cellId = "cellId"
    
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .boldSystemFont(ofSize: 34)
        label.text = "Новости"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgound")
        addSubviews()
        layoutSubviews()
        fetchData()
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellId)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.newsTableView.reloadData()
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func fetchData() {
        NetworkManager.shared.fetchNewsData(completion: { result in
            articlesArray = result
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        })
    }
    
    
    private func addSubviews() {
        view.addSubview(newsTableView)
        view.addSubview(tabTitleLabel)
    }
    
    private func layoutSubviews() {
        tabTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.leading.equalToSuperview().inset(30)
        }
        
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(tabTitleLabel.snp.bottom).inset(-23)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configure reusableCell
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsTableViewCell
        // population views in cell with data from JSON
        let article = articlesArray[indexPath.section]
        cell.delegate = self
        if let URLString = article.urlToImage {
            cell.newsImageView.sd_setImage(with: URL(string: URLString))
        }
        cell.dateLabel.text = String(article.publishedAt.prefix(10))
        cell.likeImageView.image = UIImage(systemName: "heart")
        cell.likeImageView.tintColor = UIColor(named: "Color")
        cell.postTitleLabel.text = article.title
        cell.postTextLabel.text = article.description
        if article.isFavorite == true {
            cell.likeImageView.image = UIImage(systemName: "heart.fill")
            cell.likeImageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailsViewController()
        let article = articlesArray[indexPath.section]
        if let URLString = article.urlToImage {
            vc.postImageView.sd_setImage(with: URL(string: URLString))
        }
        vc.dateLabel.text = String(article.publishedAt.prefix(10))
        vc.postTitleLabel.text = article.title
        vc.postTextLabel.text = article.description
        if article.isFavorite == true {
            vc.likeImageView.image = UIImage(systemName: "heart.fill")
            vc.likeImageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
        }
        vc.id = indexPath.section
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: TableCellDelegate {
    func didTapImageInCell( cell: UITableViewCell) {
        guard let cell = cell as? NewsTableViewCell else { return }
        guard let indexPath = newsTableView.indexPath(for: cell) else { return }
        
        
        let isAlreadyFavorite = favoritePostsArray.contains { element in
            if element.title == articlesArray[indexPath.section].title {
                return true
            } else {
                return false
            }
        }
        
        if isAlreadyFavorite == false {
            articlesArray[indexPath.section].isFavorite = true
            cell.likeImageView.image = UIImage(systemName: "heart.fill")
            cell.likeImageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
            favoritePostsArray.append(articlesArray[indexPath.section])
        }
        
    }
}
