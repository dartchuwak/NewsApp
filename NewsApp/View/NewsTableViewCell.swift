//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit

protocol TableCellDelegate: AnyObject {
    func didTapImageInCell( cell: UITableViewCell)
}

class NewsTableViewCell: UITableViewCell {
    
    
    var isVarotite: Bool = false

    weak var delegate: TableCellDelegate?
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
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
        return imageView
    }()
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addViews()
        subviewsLayout()
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    @objc private func tapped() {
        delegate?.didTapImageInCell(cell: self)
    }
    
    private func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likeImageView)
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postTextLabel)
    }
    
    private func subviewsLayout() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 132),
            dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 9),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            likeImageView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 6),
            likeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            postTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postTextLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 2),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
}
