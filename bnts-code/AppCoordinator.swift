//
//  AppCoordinator.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import UIKit

protocol AppCoordinating {
    var navigationController: UINavigationController? { get set }
    func start()
}

final class AppCoordinator: AppCoordinating {
    var navigationController: UINavigationController?
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = PhotosViewController(viewModel: PhotosViewModel())
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
    
}
