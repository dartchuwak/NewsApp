//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import SnapKit

final class NewsDetailsViewController: UIViewController {
    
    var id = Int()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Статья"
        view.backgroundColor = UIColor(named: "background")
        navigationController?.navigationBar.topItem?.title = ""
        addViews()
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likesTapped)))
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func addViews() {
        view.addSubview(postImageView)
        view.addSubview(postTitleLabel)
        view.addSubview(postTextLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(likeImageView)
    }
    
    private func layoutViews() {
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(260)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        postTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).inset(-11)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        postTextLabel.snp.makeConstraints { make in
            make.top.equalTo(postTitleLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
    
    @objc private func likesTapped() {
        let isAlreadyFavorite = favoritePostsArray.contains { element in
            if element.title == articlesArray[id].title {
                return true
            } else {
                return false
            }
        }
        
        if isAlreadyFavorite == false {
            likeImageView.image = UIImage(systemName: "heart.fill")
            likeImageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
            favoritePostsArray.append(articlesArray[id])
        }
    }
}
