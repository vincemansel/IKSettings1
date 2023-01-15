//
//  MainSettingsVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit
import SafariServices

class MainSettingsVC: BaseSettingsVC {
    
  var aboutPanel = SettingsContainer(title: "About", settingType: .action)
  var privacyPanel = SettingsContainer(title: "Privacy", settingType: .action)
  var logoutPanel = SettingsContainer(title: "Log Out", settingType: .action)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.hidesBackButton = true
  }

  override func configureDataSource() {
    aboutPanel.actionHandler      = { self.showAboutSettings() }
    privacyPanel.actionHandler    = { self.presentPrivacyPolicy() }
    logoutPanel.actionHandler     = { self.logoutAction() }

    settingsDataSource.configuration.append(aboutPanel)
    settingsDataSource.configuration.append(privacyPanel)
    settingsDataSource.configuration.append(logoutPanel)
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

// MARK: Settings Actions
extension MainSettingsVC {
  func showAboutSettings() {
    let aboutSettingsVC = AboutSettingsVC(settingsTitle: "About")
    navigationController?.pushViewController(aboutSettingsVC, animated: true)
  }
  
  private func logoutAction() {
    print("Log out")
  }
  
  private func genericPrintAction(_ text: String) {
    print(text)
  }
  
  private func presentPrivacyPolicy() {
    guard let url = URL(string: "https://github.com/ArthurGareginyan/privacy-policy-template") else {
      print("Could not parse string for URL")
      return
    }
    presentSafariVC(with: url)
  }
  
  func presentSafariVC(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemBlue
    present(safariVC, animated: true)
  }
}
