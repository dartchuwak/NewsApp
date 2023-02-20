//
//  FavoriteNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 16.02.2023.
//

import UIKit
import SnapKit

protocol CollectionViewDelegate: AnyObject {
    func didTapImageInCell( cell: UICollectionViewCell)
}



final class FavoriteNewsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CollectionViewDelegate?
    
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
        imageView.tintColor = UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1)
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
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        layoutViews()
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
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
        newsImageView.snp.makeConstraints { make in
            make.height.equalTo(95)
            make.leading.trailing.top.equalToSuperview()
        }
    
        stackView.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).inset(-11)
            make.leading.trailing.equalToSuperview().inset(9)
        }
        
        postTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(18)
        }
    }
    
    @objc private func tapped() {
        delegate?.didTapImageInCell(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
