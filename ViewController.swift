//
//  ViewController.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class ViewController: UIViewController {
  
  let tapButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGreen
    
    configure()
  }
  
  func configure() {
    view.addSubview(tapButton)
    tapButton.translatesAutoresizingMaskIntoConstraints = false
    tapButton.setTitle("Settings", for: .normal)
    
    NSLayoutConstraint.activate([
      tapButton.topAnchor.constraint(equalTo: view.topAnchor),
      tapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    tapButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
  }
  
  @objc func showSettings() {
    let navVC = UINavigationController(rootViewController: MainSettingsVC(settingsTitle: "Settings"))
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }
}
