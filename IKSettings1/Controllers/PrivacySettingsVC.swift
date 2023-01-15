//
//  PrivacySettingsVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/15/23.
//

import UIKit
import SafariServices

class PrivacySettingsVC: BaseSettingsVC {

  var privacyLinkPanel  = SettingsContainer(title: "Privacy Policy", settingType: .action)
  var sharePanel        = SettingsContainer(title: "Share Information", settingType: .toggle)
  
  override func configureDataSource() {
    privacyLinkPanel.actionHandler = { self.presentPrivacyPolicy() }
    sharePanel.info = "com.IKSettings1.Privacy.shareInformation"
    
    settingsDataSource.setConfiguration(privacyLinkPanel, sharePanel)
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
