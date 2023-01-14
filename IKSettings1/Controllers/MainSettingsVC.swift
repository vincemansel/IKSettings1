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

    settingsDataSource = MainSettingsDataSource()
  }

  override func configureDataSource() {
    aboutPanel.actionHandler      = { self.showAboutSettings() }
    privacyPanel.actionHandler    = { self.genericPrintAction("Privacy") }
    logoutPanel.actionHandler     = { self.logoutAction() }

    settingsDataSource.configuration.append(aboutPanel)
    settingsDataSource.configuration.append(privacyPanel)
    settingsDataSource.configuration.append(logoutPanel)
  }
  
  private func logoutAction() {
    print("Log out")
  }
  
  private func genericPrintAction(_ text: String) {
    print(text)
  }
}

// MARK: Actions
extension MainSettingsVC {
  func showAboutSettings() {
    let aboutSettingsVC = AboutSettingsVC(settingsTitle: "About")
    navigationController?.pushViewController(aboutSettingsVC, animated: true)
  }
}
