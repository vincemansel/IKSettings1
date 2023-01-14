//
//  LoginVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit
import Combine

class LoginVC: UIViewController {
  
  let usernameTextField = IKLoginTextField()
  let passwordTextField = IKLoginTextField()
  let actionButton      = IKButton()
  
  @Published private var username = ""
  @Published private var password = ""
  
  private var actionButtonSubscriber: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureSubviews()
    configureTextFields()
    configureActionButton()
  }
  
  private func configureTextFields() {
    usernameTextField.setPlaceholderText("Username")
    passwordTextField.setPlaceholderText("Password")
    passwordTextField.isSecureTextEntry = true
    
    usernameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  private func configureActionButton() {
    actionButton.setTitle("Log In", for: .normal)
    actionButton.isEnabled = false
    
    actionButtonSubscription()
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
      usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -85),
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

// MARK: Combine: ActionButton
extension LoginVC {
  private var validatedToEnableActionButton: AnyPublisher<Bool, Never> {
    return Publishers.CombineLatest($username, $password)
      .map { username, password in
        username.count >= 6 && password.count >= 8
      }.eraseToAnyPublisher()
  }
  
  private func actionButtonSubscription() {
    actionButtonSubscriber = validatedToEnableActionButton
      .receive(on: RunLoop.main)
      .assign(to: \.isEnabled, on: actionButton)
  }
}

extension LoginVC: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    let textFieldText = textField.text ?? ""
    let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
    
    if textField == usernameTextField { username = text }
    if textField == passwordTextField { password = text }
    
    return true
  }
}
