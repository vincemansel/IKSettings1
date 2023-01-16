//
//  CustomURLRouter.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/15/23.
//

/*
 Reference:
 https://benoitpasquier.com/deep-linking-url-scheme-ios/
 
 To test from simulator:
 xcrun simctl openurl booted "IKSettings1://root"
 */
import UIKit

protocol URLRouterHandlerProtocol {
  func canOpenURL(_ url: URL) -> Bool
  func openURL(_ url: URL)
}

protocol URLRouterCoordinatorProtocol {
  @discardableResult
  func handleURL(_ url: URL) -> Bool
}

final class URLRouterCoordinator {
  
  let handlers: [URLRouterHandlerProtocol]
  
  init(handlers: [URLRouterHandlerProtocol]) {
    self.handlers = handlers
  }
}

extension URLRouterCoordinator: URLRouterCoordinatorProtocol {
  
  @discardableResult
  func handleURL(_ url: URL) -> Bool{
    guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
      return false
    }
    
    handler.openURL(url)
    return true
  }
}

final class MainSettingsURLRouterHandler: URLRouterHandlerProtocol {
  
  private weak var rootViewController: UIViewController?
  init(rootViewController: UIViewController?) {
    self.rootViewController = rootViewController
  }
  
  // MARK: - URLRouterHandlerProtocol
  
  func canOpenURL(_ url: URL) -> Bool {
    return url.absoluteString == "IKSettings1://root"
  }
  
  func openURL(_ url: URL) {
    guard canOpenURL(url) else {
      return
    }
    
    let navVC = rootViewController as? UINavigationController
    
    if LoginVC.getLoginStatus() {
      let viewController = MainSettingsVC(settingsTitle: "Settings")
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
    }
  }
}

final class AboutSettingsURLRouterHandler: URLRouterHandlerProtocol {
  
  private weak var rootViewController: UIViewController?
  init(rootViewController: UIViewController?) {
    self.rootViewController = rootViewController
  }
  
  // MARK: - URLRouterHandlerProtocol
  
  func canOpenURL(_ url: URL) -> Bool {
    return url.absoluteString == "IKSettings1://about"
  }
  
  func openURL(_ url: URL) {
    guard canOpenURL(url) else {
      return
    }
    
    let navVC = rootViewController as? UINavigationController
    
    if LoginVC.getLoginStatus() {
      let viewController = AboutSettingsVC(settingsTitle: "About")
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
    }
  }
}

final class PrivacySettingsURLRouterHandler: URLRouterHandlerProtocol {
  
  private weak var rootViewController: UIViewController?
  init(rootViewController: UIViewController?) {
    self.rootViewController = rootViewController
  }
  
  // MARK: - URLRouterHandlerProtocol
  
  func canOpenURL(_ url: URL) -> Bool {
    return url.absoluteString == "IKSettings1://privacy"
  }
  
  func openURL(_ url: URL) {
    guard canOpenURL(url) else {
      return
    }
    
    let navVC = rootViewController as? UINavigationController

    if LoginVC.getLoginStatus() {
      let viewController = PrivacySettingsVC(settingsTitle: "Privacy")
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
    }
  }
}
