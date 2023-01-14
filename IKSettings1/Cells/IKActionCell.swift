//
//  IKActionCell.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

typealias TapHandler = () -> Void

class IKActionCell: UITableViewCell {
  
  static let reuseId = "IKActionCell"
  
  struct Content {
    let tapHandler: TapHandler
  }
  
  let titleLabel = IKTitleLabel(textAlignment: .left, fontSize: 16)
  let actionImage = UIImageView()
  
  private lazy var tapButton: UIButton = {
    let button = UIButton()
    button.addAction(UIAction(handler: {[weak self] _ in
      self?.handleTap()
    }), for: .touchUpInside)
    button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private var tapHandler: TapHandler?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(title: String, content: Content? = nil) {
    titleLabel.text = title
    if let content = content {
      tapHandler = content.tapHandler
    }
  }
  
  func configure() {
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(actionImage)
    contentView.addSubview(tapButton)
    
    actionImage.image = UIImage(systemName: "chevron.right")
    actionImage.tintColor = .label

    translatesAutoresizingMaskIntoConstraints = false
    actionImage.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
      titleLabel.heightAnchor.constraint(equalToConstant: 40),
      
      actionImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      actionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      actionImage.widthAnchor.constraint(equalToConstant: 16),
      actionImage.heightAnchor.constraint(equalToConstant: 16)
    ])
    
    NSLayoutConstraint.activate([
      tapButton.topAnchor.constraint(equalTo: contentView.topAnchor),
      tapButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      tapButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      tapButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  private func handleTap() {
    // This calls back to the injected closure
    tapHandler?()
  }
}
