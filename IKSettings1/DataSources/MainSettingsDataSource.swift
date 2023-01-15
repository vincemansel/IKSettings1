//
//  MainSettingsDataSource.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

struct MainSettingsDataSource: SettingsDataSource {
  var configuration: [SettingConfiguration] = []
  
  mutating func setConfiguration(_ configs: SettingConfiguration ...) {
    configs.forEach { config in configuration.append(config) }
  }
}

struct SettingsContainer: SettingConfiguration {
  var title: String
  var info: String?
  var settingType: SettingsType
  var actionHandler: TapHandler?
}
