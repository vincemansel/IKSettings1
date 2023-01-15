//
//  BaseSettingsVC.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class BaseSettingsVC: UIViewController, SettingsCapable {  

  var settingsDataSource: SettingsDataSource = MainSettingsDataSource()
  
  var tableView: UITableView!
  var settingsTitle: String?
  
  init(settingsTitle: String) {
    self.settingsTitle = settingsTitle
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTitle()
    configureDataSource()
    configureView()
  }
  
  final func configureView() {
    view.backgroundColor = .systemBackground

    title = settingsTitle
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView = UITableView()
    view.addSubview(tableView)

    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.frame = view.bounds
    tableView.rowHeight = 75
    
    tableView.register(IKSettingsCell.self, forCellReuseIdentifier: IKSettingsCell.reuseId)
    tableView.register(IKActionCell.self, forCellReuseIdentifier: IKActionCell.reuseId)
    tableView.register(IKToggleCell.self, forCellReuseIdentifier: IKToggleCell.reuseId)

    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = false
    
    tableView.reloadData()
  }
  
  func setTitle() {
    title = settingsTitle
  }
  
  func configureDataSource() {
    fatalError("\(#function): Subclasses must override.")
  }
}

extension BaseSettingsVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingsDataSource.configuration.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let datasource = settingsDataSource.configuration[indexPath.row]
    let title = datasource.title
    switch datasource.settingType {
      case .info:
        return configureSettingsCell(title: title, infoText: datasource.info ?? "", at: indexPath)
      case .action:
        return configureActionCell(title: title, handler: datasource.actionHandler!, at: indexPath)
      case .group:
        return configureActionCell(title: title, handler: datasource.actionHandler!, at: indexPath)
      case .toggle:
        return configureToggleCell(title: title, defaultsKey: datasource.info ?? "", at: indexPath)
    }
  }
  
  private func configureSettingsCell(title: String, infoText: String, at indexPath: IndexPath) -> IKSettingsCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: IKSettingsCell.reuseId, for: indexPath) as? IKSettingsCell else { return UITableViewCell() as! IKSettingsCell }
    cell.set(title: title, infoText: infoText)
    return cell
  }
  
  private func configureActionCell(title: String, handler: @escaping TapHandler, at indexPath: IndexPath) -> IKActionCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: IKActionCell.reuseId, for: indexPath) as? IKActionCell else { return UITableViewCell() as! IKActionCell }
    cell.set(title: title, content: IKActionCell.Content(tapHandler: handler))
    return cell
  }
  
  private func configureToggleCell(title: String, defaultsKey: String, at indexPath: IndexPath) -> IKToggleCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: IKToggleCell.reuseId, for: indexPath) as? IKToggleCell else { return UITableViewCell() as! IKToggleCell}
    cell.set(title: title, defaultsKey: defaultsKey)
    return cell
  }
}

