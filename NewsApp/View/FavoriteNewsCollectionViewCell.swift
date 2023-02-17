//
//  FavoriteNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 16.02.2023.
//

import UIKit



class FavoriteNewsCollectionViewCell: UICollectionViewCell {
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .red
        return imageView
    }()
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        layoutViews()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 22
        self.clipsToBounds = true
    }
    
    
    private func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(postTitleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(likeImageView)
        contentView.addSubview(stackView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
        newsImageView.heightAnchor.constraint(equalToConstant: 95),
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        newsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        stackView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 11),
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
        postTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
        postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        postTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        
        
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
