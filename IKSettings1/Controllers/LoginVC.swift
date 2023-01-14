//
//  LoginVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class LoginVC: UIViewController {
  
  let usernameTextField = IKLoginTextField()
  let passwordTextField = IKLoginTextField()
  let actionButton      = IKButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureSubviews()
    configureActionButton()
  }
  
  private func configureActionButton() {
    actionButton.setTitle("Log In", for: .normal)
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
  }
  
  private func configureSubviews() {
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(actionButton)
    
    usernameTextField.setPlaceholderText("Username")
    passwordTextField.setPlaceholderText("Password")
    passwordTextField.isSecureTextEntry = true
    
    NSLayoutConstraint.activate([
      usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
      usernameTextField.heightAnchor.constraint(equalToConstant: 44),
      usernameTextField.widthAnchor.constraint(equalToConstant: 220),
      
      passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
      passwordTextField.heightAnchor.constraint(equalToConstant: 44),
      passwordTextField.widthAnchor.constraint(equalToConstant: 220),
      
      actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
      actionButton.heightAnchor.constraint(equalToConstant: 44),
      actionButton.widthAnchor.constraint(equalToConstant: 150),
    ])
  }
}
