//
//  IKTitleLabel.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class IKTitleLabel: UILabel {

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    configure()
  }
  
  private func configure() {
    textColor                   = .label
    adjustsFontSizeToFitWidth   = true
    minimumScaleFactor          = 0.9
    lineBreakMode               = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }

}

