//
//  IKButton.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class IKButton: UIButton {  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(color: UIColor, title: String, systemImageName: String) {
    self.init(frame: .zero)
    set(color: color, title: title, systemImageName: systemImageName)
  }
  
  private func configure() {
    configuration = .filled()
    configuration?.cornerStyle = .medium
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func set(color: UIColor, title: String, systemImageName: String) {
    configuration?.baseBackgroundColor = color
    configuration?.baseForegroundColor = .white
    configuration?.title = title
    
    configuration?.image = UIImage(systemName: systemImageName)
    configuration?.imagePadding = 6
    configuration?.imagePlacement = .trailing
  }
  
  func update(title: String, systemImageName: String) {
    configuration?.title = title
    configuration?.image = UIImage(systemName: systemImageName)
  }
}
