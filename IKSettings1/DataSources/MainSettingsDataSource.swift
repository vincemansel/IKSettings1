//
//  MainSettingsDataSource.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

struct MainSettingsDataSource: SettingsDataSource {
  var configuration: [SettingConfiguration] = [About(), Privacy(), LogOut(), Share()]
  
  struct About: SettingConfiguration {
    var title: String = "About"
    var info: String?
    var settingType: SettingsType = .group
    var actionHandler: TapHandler?
  }
  
  struct Privacy: SettingConfiguration {
    var title: String = "Privacy"
    var info: String?
    var settingType: SettingsType = .group
    var actionHandler: TapHandler?
  }
  
  struct LogOut: SettingConfiguration {
    var title: String = "Log Out"
    var info: String?
    var settingType: SettingsType = .action
    var actionHandler: TapHandler?
  }
  
  struct Share: SettingConfiguration {
    var title: String = "Share"
    var info: String? = "com.IKSettings1.Settings.ShareDataKey"
    var settingType: SettingsType = .toggle
    var actionHandler: TapHandler?
  }
}
