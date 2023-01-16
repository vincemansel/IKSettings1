//
//  MainSettingsVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class MainSettingsVC: BaseSettingsVC {
    
  var aboutPanel = SettingsContainer(title: "About", settingType: .action)
  var privacyPanel = SettingsContainer(title: "Privacy", settingType: .action)
  var logoutPanel = SettingsContainer(title: "Log Out", settingType: .action)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  private func configureViewController() {
    navigationItem.hidesBackButton = true
  }

  override func configureDataSource() {
    aboutPanel.actionHandler      = { self.showNextSettings(self.aboutPanel.title) }
    privacyPanel.actionHandler    = { self.showNextSettings(self.privacyPanel.title) }
    logoutPanel.actionHandler     = { self.logoutAction() }
    
    settingsDataSource.setConfiguration(aboutPanel, privacyPanel, logoutPanel)
  }
}

// MARK: Settings Actions
extension MainSettingsVC {
  private func showNextSettings(_ title: String) {
    var nextSettingsVC: BaseSettingsVC
    
    switch title {
      case "About":
        nextSettingsVC = AboutSettingsVC(settingsTitle: title)
      case "Privacy":
        nextSettingsVC = PrivacySettingsVC(settingsTitle: title)
      default:
        fatalError("Unknown VC: \(title)")
    }
    
    navigationController?.pushViewController(nextSettingsVC, animated: true)
  }
  
  private func logoutAction() {
    LoginVC.setLoginStatus(false)
    navigationController?.popViewController(animated: true)
  }
  
  private func genericPrintAction(_ text: String) {
    print(text)
  }
}
