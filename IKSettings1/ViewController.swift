//
//  ViewController.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class ViewController: UIViewController {
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    view.backgroundColor = .systemMint
    
    configureView()
    
    tableView.reloadData()
  }
  
  private func configureView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.rowHeight = 75
    
    tableView.register(IKSettingsCell.self, forCellReuseIdentifier: IKSettingsCell.reuseId)
    tableView.register(IKActionCell.self, forCellReuseIdentifier: IKActionCell.reuseId)
    tableView.register(IKToggleCell.self, forCellReuseIdentifier: IKToggleCell.reuseId)

    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = false
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
      case 0:
        return configureSettingsCell(title: "Title", informationalText: "InformationalText", at: indexPath)
      case 1:
        return configureActionCell(title: "Action", handler: { print("tapped") }, at: indexPath)
      case 2:
        return configureActionCell(title: "Group", handler: { print("Group")}, at: indexPath)
      case 3:
        return configureToggleCell(title: "Toggle", defaultsKey: "ShareData", at: indexPath)
      default:
        return UITableViewCell()
    }    
  }
  
  private func configureSettingsCell(title: String, informationalText: String, at indexPath: IndexPath) -> IKSettingsCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: IKSettingsCell.reuseId, for: indexPath) as? IKSettingsCell else { return UITableViewCell() as! IKSettingsCell }
    cell.set(title: title, infoText: informationalText)
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

