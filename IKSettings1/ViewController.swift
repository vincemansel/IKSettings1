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
    // Do any additional setup after loading the view.
    
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
    
    tableView.backgroundColor = .systemBackground
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: IKSettingsCell.reuseId, for: indexPath) as? IKSettingsCell else {
      return UITableViewCell()
    }
    
    cell.set(title: "Title", infoText: "Informational Text")
    return cell
  }
}

