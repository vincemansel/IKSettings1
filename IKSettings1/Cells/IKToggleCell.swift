//
//  IKToggleCell.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class IKToggleCell: UITableViewCell {
  
  static let reuseId = "IKToggleCell"
  
  let titleLabel = IKTitleLabel(textAlignment: .left, fontSize: 16)
  var toggle     = UISwitch()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
    configureToggleAction()
  }
  
  var defaultsKey: String = ""
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(title: String, defaultsKey: String) {
    titleLabel.text = title
    self.defaultsKey = defaultsKey
  }
  
  func configure() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(toggle)
    toggle.translatesAutoresizingMaskIntoConstraints = false
    toggle.preferredStyle = .sliding
    
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
      titleLabel.heightAnchor.constraint(equalToConstant: 40),
      
      toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
    ])
  }
  
  func configureToggleAction() {
    toggle.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
  }
  
  @objc func switchStateDidChange() {
    let defaults = UserDefaults.standard
    
    if toggle.isOn {
      defaults.set(true, forKey: defaultsKey)
    }
    else {
      defaults.set(false, forKey: defaultsKey)
    }
  }
}
