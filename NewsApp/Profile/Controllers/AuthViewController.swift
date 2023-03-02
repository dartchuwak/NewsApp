//
//  AuthViewController.swift
//  NewsApp
//
//  Created by Evgenii Mikhailov on 16.02.2023.
//

import UIKit
import Firebase

final class AuthViewController: UIViewController {
    
    var isInRegistrationMode: Bool = false
    
    let passwordResetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button .setTitle("Забыли пароль?", for: .normal)
        button.tintColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 1)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        button.isHidden = false
        return button
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textFiled = LeftPaddedTextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        textFiled.layer.cornerRadius = 20
        textFiled.clipsToBounds = true
        textFiled.placeholder = "Почта"
        textFiled.keyboardType = .emailAddress
        return textFiled
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textFiled = LeftPaddedTextField()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        textFiled.layer.cornerRadius = 20
        textFiled.clipsToBounds = true
        textFiled.placeholder = "Пароль"
        textFiled.isSecureTextEntry = true
        return textFiled
    }()
    
    let enterButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Вход", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 1)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        return button
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Зарегистрироватья"
        label.textColor = UIColor(named: "Color")
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта ?"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.title = "Вход"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        addViews()
        layoutViews()
        enterButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        passwordResetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutViews() {
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(42)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(45)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(42)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailTextField.snp.bottom).inset(-15)
        }
        
        enterButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(42)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(enterButton.snp.bottom).inset(-20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        passwordResetButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
        }

    }
    
    private func addViews() {
        view.addSubview(enterButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(registerLabel)
        view.addSubview(stackView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordResetButton)
    }
    
    // Changes mode from sign in to registration and backwards
    @objc private func onTap() {
        if isInRegistrationMode == false {
            self.title = "Регистрация"
            label.text = "У вас есть аккаунт?"
            registerLabel.text = "Войти"
            isInRegistrationMode.toggle()
            passwordResetButton.isHidden.toggle()
        } else {
            self.title = "Вход"
            label.text = "Нет аккаунта?"
            registerLabel.text = "Зарегистрироваться"
            isInRegistrationMode.toggle()
            passwordResetButton.isHidden.toggle()
        }
    }
    
    @objc private func resetPressed() {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    @objc private func pressed() {
        
        // Check if textfields is nil or empty
        if (emailTextField.text == "" || passwordTextField.text == "") || (emailTextField.text == nil || passwordTextField.text == nil) {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните пустые поля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            // Gets email and password from tf
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            if isInRegistrationMode == false {
                // sign in into firebase with email and password if vc is in "enter" mode
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.showAlert(title: "Ошибка аутентификации:", text: error.localizedDescription)
                        print("Ошибка аутентификации: \(error.localizedDescription)")
                        return
                    }
                    guard let user = authResult?.user else {
                        self.showAlert(title: "Ошибка!", text: "Пользователь не найден")
                        print("Пользователь не найден")
                        return
                    }
                    print("Пользователь успешно аутентифицирован: \(String(describing: user.email))")
                    let tabBarController = TabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true)
                }
            } else {
                // creates new user into firebase and sign in in "registration" mode
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Ошибка аутентификации: \(error.localizedDescription)")
                        return
                    }
                    guard let user = authResult?.user else {
                        print("Пользователь не найден")
                        return
                    }
                    print("Пользователь успешно аутентифицирован: \(user.email ?? "")")
                    let tabBarController = TabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true)
                }
            }
        }
    }
    
    private func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return false
    }
}
