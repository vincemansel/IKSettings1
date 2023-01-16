//
//  CustomURLRouter.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/15/23.
//

/*
 Reference:
 https://benoitpasquier.com/deep-linking-url-scheme-ios/
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
    
    let viewController = MainSettingsVC(settingsTitle: "Settings")
    let navVC = rootViewController as? UINavigationController
    navVC?.pushViewController(viewController, animated: true)
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
    
    let viewController = AboutSettingsVC(settingsTitle: "About")
    let navVC = rootViewController as? UINavigationController
    navVC?.pushViewController(viewController, animated: true)
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
    
    let viewController = PrivacySettingsVC(settingsTitle: "Privacy")
    let navVC = rootViewController as? UINavigationController
    navVC?.pushViewController(viewController, animated: true)
  }
}
