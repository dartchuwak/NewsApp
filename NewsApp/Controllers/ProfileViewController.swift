//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 15.02.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
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
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: tabTitleLabel.bottomAnchor, constant: 23),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            userIdLabel.widthAnchor.constraint(equalToConstant: 300),
            userIdLabel.heightAnchor.constraint(equalToConstant: 44),
            userIdLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 27),
            userIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            userEmailLabel.widthAnchor.constraint(equalToConstant: 300),
            userEmailLabel.heightAnchor.constraint(equalToConstant: 44),
            userEmailLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 16),
            userEmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            tabTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 49),
            tabTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
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
