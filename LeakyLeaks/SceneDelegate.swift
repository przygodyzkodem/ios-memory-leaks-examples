//
//  SceneDelegate.swift
//  LeakyLeaks
//
//  Created by Michał Zięba on 23/01/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene,
           let mainViewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController() {
            window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController.init(rootViewController: mainViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}

