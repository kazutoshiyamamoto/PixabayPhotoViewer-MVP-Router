//
//  SceneDelegate.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let searchImageViewController = UIStoryboard(name: "SearchImage", bundle: nil).instantiateInitialViewController() as! SearchImageViewController
        let navigationController = UINavigationController(rootViewController: searchImageViewController)
        let model = SearchImageModel()
        let router = SearchImageRouter(view: searchImageViewController)
        let presenter = SearchImagePresenter(view: searchImageViewController,
                                             model: model,
                                             router: router)
        searchImageViewController.inject(presenter: presenter)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}



