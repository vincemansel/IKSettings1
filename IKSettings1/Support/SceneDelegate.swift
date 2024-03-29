//
//  SceneDelegate.swift
//  IKSettings1
//
//  Created by Vince Mansel on 1/13/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  lazy var urlRouterCoordinator: URLRouterCoordinatorProtocol = {
      return URLRouterCoordinator(handlers: [
          MainSettingsURLRouterHandler(rootViewController: self.rootViewController),
          AboutSettingsURLRouterHandler(rootViewController: self.rootViewController),
          PrivacySettingsURLRouterHandler(rootViewController: self.rootViewController)
      ])
  }()

  var rootViewController: UIViewController? {
      return window?.rootViewController
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let navVC = UINavigationController(rootViewController: LoginVC())
    window?.rootViewController = navVC
    window?.makeKeyAndVisible()
    
    // This opens the app if not currently launched
    if let urlContext = connectionOptions.urlContexts.first {
      let url = urlContext.url
      self.urlRouterCoordinator.handleURL(url)
    }
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    
    LoginVC.setLoginStatus(false)
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let firstUrl = URLContexts.first?.url else {
      return
    }
    
    // This opens the app if backgrounded or susupended.
    urlRouterCoordinator.handleURL(firstUrl)
  }
}

