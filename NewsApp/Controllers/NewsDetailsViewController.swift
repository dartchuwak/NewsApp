//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit

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
        imageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
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
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            postImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 260),
            stackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            postTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            postTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            postTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            postTextLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 8),
            postTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            postTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -14)
        ])
    }
    
    @objc private func likesTapped() {
        let b = favoritePostsArray.contains { element in
            if element.title == articlesArray[id].title {
                return true
            } else {
                return false
            }
        }
        
        if !b {
            likeImageView.image = UIImage(systemName: "heart.fill")
            likeImageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
            favoritePostsArray.append(articlesArray[id])
        }
    }
}
