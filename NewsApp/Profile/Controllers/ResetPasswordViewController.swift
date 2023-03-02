//
//  ResetPasswordViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 16.02.2023.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
    
    let emailTextFiled: LeftPaddedTextField = {
        let textFiled = LeftPaddedTextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        textFiled.layer.cornerRadius = 20
        textFiled.clipsToBounds = true
        textFiled.placeholder = "name@mail.com"
        textFiled.keyboardType = .emailAddress
        return textFiled
    }()
    
    let enterButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Сбросить пароль", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 1)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        return button
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Инструкция по сбросу пароля придет Вам на почту"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        emailTextFiled.delegate = self
        self.title = "Сброс пароля"
        view.addSubview(emailTextFiled)
        view.addSubview(enterButton)
        view.addSubview(label)
        enterButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        emailTextFiled.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
        }
        
        enterButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailTextFiled.snp.bottom).inset(-20)
            make.width.equalTo(200)
            make.height.equalTo(42)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(enterButton.snp.bottom).inset(-10)
            make.width.equalTo(300)
        }
    }
    
    @objc private func tapped() {
        guard let email = emailTextFiled.text else { return }
        if isValidEmail(email: email) != true {
            let alert = UIAlertController(title: "Ошибка", message: "Проверьте корректность введенных данных", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }


}

extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextFiled.endEditing(true)
        return false
    }
}
