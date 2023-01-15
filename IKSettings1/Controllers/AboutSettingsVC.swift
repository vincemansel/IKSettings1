//
//  AboutSettingsVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class AboutSettingsVC: BaseSettingsVC {
  var appVersionPanel = SettingsContainer(title: "App Version", settingType: .info)
  var appLanguagePanel = SettingsContainer(title: "App Language", settingType: .info)
  
  override func configureDataSource() {
    appVersionPanel.info  = getCurrentAppVersion()
    appLanguagePanel.info = getPreferredLanguageCode()
    
    settingsDataSource.setConfiguration(appVersionPanel, appLanguagePanel)
  }
  
  private func getCurrentAppVersion() -> String {
    return "1.0.0.1"
  }
  
  private func getPreferredLanguageCode() -> String {
    var langCode = NSLocale.preferredLanguages[0] as String
    if let cc = Locale.current.language.region?.identifier {
      langCode += "-\(cc)"
    }
    return langCode
  }
}
