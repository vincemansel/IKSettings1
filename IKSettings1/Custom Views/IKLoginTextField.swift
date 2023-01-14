//
//  IKLoginTextField.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/14/23.
//

import UIKit

class IKLoginTextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius          = 0
    layer.borderWidth           = 2
    layer.borderColor           = UIColor.systemGray4.cgColor
    
    textColor                   = .label
    tintColor                   = .label
    textAlignment               = .left
    font                        = UIFont.preferredFont(forTextStyle: .title3)
    font                        = UIFont.systemFont(ofSize: 18, weight: .regular)
    adjustsFontSizeToFitWidth   = true
    minimumFontSize             = 12
    
    backgroundColor             = .tertiarySystemBackground
    autocorrectionType          = .no
    returnKeyType               = .go
    // Optional
    clearButtonMode             = .never
    // Optional - to remove the accessoryView on top of keyboard
    spellCheckingType           = .no
    placeholder                 = "Enter a username"
  }
  
  func setPlaceholderText(_ text: String) {
    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5),
                      .font : UIFont.italicSystemFont(ofSize: 18)]

    attributedPlaceholder = NSAttributedString(string: text, attributes:attributes)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRectInset(bounds, 10, 10)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRectInset(bounds, 10, 10)
  }
  
}
