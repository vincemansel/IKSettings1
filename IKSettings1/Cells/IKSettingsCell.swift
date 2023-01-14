//
//  IKSettingsCell.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class IKSettingsCell: UITableViewCell {
  
  static let reuseId = "IKSettingsCell"
  
  let titleLabel = IKTitleLabel(textAlignment: .left, fontSize: 16)
  let infoLabel  = IKInfoLabel(textAlignment: .right, fontSize: 12)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(title: String, infoText: String) {
    titleLabel.text = title
    infoLabel.text = infoText
  }
  
  func configure() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(infoLabel)
    
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
      titleLabel.heightAnchor.constraint(equalToConstant: 40),
      
      infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      infoLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
      infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      infoLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
