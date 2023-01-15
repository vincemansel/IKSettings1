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
  @Published private var buttonTapped = false
  @Published private var credentials = [String]()
  
  private var actionButtonSubscriber: AnyCancellable?
  private var credentialsValidatedSubscriber: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureSubviews()
    configureTextFields()
    configureActionButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    actionButtonSubscription()
    credentialSubscription()
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
    actionButton.addTarget(self, action: #selector(onActionButtonTapped), for: .touchUpInside)
  }
  
  @objc func onActionButtonTapped() {
    self.credentials = [self.username, self.password]
  }
  
  func onCredentialsResultsReady(_ result: Bool) {
    defer {
      credentials = []
      credentialsValidatedSubscriber = nil
      credentialSubscription()
    }
    
    guard result else { print("Try again"); return }
    
    navigationController?.pushViewController(MainSettingsVC(settingsTitle: "Settings"), animated: true)
    
    actionButtonSubscriber = nil
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  private func configureSubviews() {
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(actionButton)
    
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
  
  private func credentialSubscription() {
    credentialsValidatedSubscriber = validatedCredentials
      .map { $0 != nil }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { result in
        print("Validated = \(result)")
        self.onCredentialsResultsReady(result)
      })
  }
}

// MARK: Combine: Credential Validation
extension LoginVC {
  private var validatedCredentials: AnyPublisher<[String]?, Never> {
    return $credentials
      .dropFirst(1)
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .flatMap { credentials in
        return Future { promise in
          self.validateCredentials(credentials) { validated in
            promise(.success(validated ? credentials : nil))
          }
        }
      }.eraseToAnyPublisher()
  }
  
  func validateCredentials(_ credentials: [String], completion: (Bool) -> Void) {
    var result = false
    defer {
      completion(result)
    }
    
    guard !credentials.isEmpty else {
      return
    }
    
    result = credentials[0].lowercased() == "vince123" && credentials[1] == "12345678"

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
