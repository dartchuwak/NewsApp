//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import SnapKit

protocol TableCellDelegate: AnyObject {
    func didTapImageInCell( cell: UITableViewCell)
}

final class NewsTableViewCell: UITableViewCell {
    
    
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
        
        newsImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(132)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).inset(-9)
            make.leading.equalToSuperview().inset(18)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).inset(-6)
            make.trailing.equalToSuperview().inset(19)
        }
        
        postTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(-11)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        postTextLabel.snp.makeConstraints { make in
            make.top.equalTo(postTitleLabel.snp.bottom).inset(-2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
}
