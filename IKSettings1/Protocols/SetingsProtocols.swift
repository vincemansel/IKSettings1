//
//  SetingsProtocols.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

enum SettingsType {
  case info, action, group, toggle
}

protocol SettingConfiguration {
  var title: String { get }
  var info:  String? { get }
  var settingType: SettingsType { get }
  var actionHandler: TapHandler? { get set }
}

protocol SettingsDataSource {
  var configuration: [SettingConfiguration] { get set }
}
