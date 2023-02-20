//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    let favotireNewsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "background")
        return collectionView
    }()
    
    let tabTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .boldSystemFont(ofSize: 34)
        label.text = "Избранное"
        return label
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 164, height: 191)
        layout.minimumInteritemSpacing = 18
        layout.minimumLineSpacing = 18
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favotireNewsCollectionView)
        view.addSubview(tabTitleLabel)
        favotireNewsCollectionView.delegate = self
        favotireNewsCollectionView.dataSource = self
        favotireNewsCollectionView.collectionViewLayout = layout
        favotireNewsCollectionView.register(FavoriteNewsCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        tabTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.leading.equalToSuperview().inset(30)
        }
        
        favotireNewsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tabTitleLabel.snp.bottom).inset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favotireNewsCollectionView.reloadData()
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritePostsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 164, height: 191)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! FavoriteNewsCollectionViewCell
        let article = favoritePostsArray[indexPath.item]
        if let url = article.urlToImage {
            cell.newsImageView.sd_setImage(with: URL(string: url))
        }
        cell.dateLabel.text = String(article.publishedAt.prefix(10))
        cell.postTitleLabel.text = article.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewsDetailsViewController()
        let article = favoritePostsArray[indexPath.item]
        vc.postImageView.sd_setImage(with: URL(string: article.urlToImage!))
        vc.dateLabel.text = String(article.publishedAt.prefix(10))
        vc.postTitleLabel.text = article.title
        vc.postTextLabel.text = article.description
        vc.likeImageView.image = UIImage(systemName: "heart.fill")
        vc.likeImageView.tintColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 14, bottom: 14, right: 14)
        }
    }
