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
    let viewController = MainSettingsVC(settingsTitle: "Settings")

    if LoginVC.getLoginStatus() {
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
      if let loginVC = navVC?.viewControllers[0] as? LoginVC {
        loginVC.nextViewController = viewController
      }
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
    let viewController = AboutSettingsVC(settingsTitle: "About")

    if LoginVC.getLoginStatus() {
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
      if let loginVC = navVC?.viewControllers[0] as? LoginVC {
        loginVC.nextViewController = viewController
      }
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
    let viewController = PrivacySettingsVC(settingsTitle: "Privacy")
    
    if LoginVC.getLoginStatus() {
      navVC?.pushViewController(viewController, animated: true)
    }
    else {
      print("Can not deep link now!")
      if let loginVC = navVC?.viewControllers[0] as? LoginVC {
        loginVC.nextViewController = viewController
      }
    }
  }
}
