//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import SnapKit

final class ProfileViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .boldSystemFont(ofSize: 34)
        label.text = "Профиль"
        return label
    }()
    
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  Имя"
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
    }()
    
    let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setTitle("Выйти", for: .normal)
        return button
    }()
    
    let userEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  name@mail.com"
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        viewsLayout()
        getUserData()
        getImageData()
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        
    }
    
    private func getUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        let email = user.email
        userIdLabel.text = uid
        userEmailLabel.text = email
    }
    
    private func addSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(userIdLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(exitButton)
        view.addSubview(tabTitleLabel)
    }
    
    private func viewsLayout() {
        
        tabTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).inset(49)
            make.leading.equalToSuperview().inset(30)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(tabTitleLabel.snp.bottom).inset(-23)
            make.centerX.equalTo(view.snp.centerX)
            make.height.width.equalTo(100)
        }
        
        userIdLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(44)
            make.top.equalTo(profileImageView.snp.bottom).inset(-27)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(44)
            make.top.equalTo(userIdLabel.snp.bottom).inset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
        exitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc private func exitTapped() {
        let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Выход", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true)
                print("Пользователь успешно вышел")
            } catch let signOutError as NSError {
                print("Ошибка выхода пользователя: \(signOutError.localizedDescription)")
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    private func getImageData() {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("avatar.jpg")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error downloading image: \(error)")
          } else {
            let image = UIImage(data: data!)
              self.profileImageView.image = image
          }
        }

    }
}
