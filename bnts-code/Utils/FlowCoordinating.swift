//
//  FlowCoordinator.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import UIKit

protocol FlowCoordinating {
    var navigationController: UINavigationController { get set }
    func start()
}

enum NavigationType {
    case push(UIViewController)
    case present(UIViewController, UIModalPresentationStyle)
    case dismiss
    case pop
    case none
    case sheet(UIViewController, [UISheetPresentationController.Detent])
}

extension FlowCoordinating {
    func navigate(type: NavigationType) {
        switch type {
        case .dismiss:
            if let presentedViewController = navigationController.presentedViewController {
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                navigationController.topViewController?.dismiss(animated: true, completion: nil)
            }
            
        case .push(let controller):
            if let topNavVC = navigationController.presentedViewController as? UINavigationController {
                topNavVC.pushViewController(controller, animated: true)
            } else {
                navigationController.pushViewController(controller, animated: true)
            }
            
        case .pop:
            if let topNavVC = navigationController.presentedViewController as? UINavigationController {
                topNavVC.popViewController(animated: true)
            } else {
                navigationController.popViewController(animated: true)
            }
            
        case .present(let controller, let style):
            controller.modalPresentationStyle = style
            
            if let presentedViewController = navigationController.presentedViewController {
                presentedViewController.present(controller, animated: true, completion: nil)
            } else {
                navigationController.topViewController?.present(
                    controller,
                    animated: true,
                    completion: nil
                )
            }
            
        case .sheet(let controller, let detents):
            if let presentedViewController = navigationController.presentedViewController {
                if let sheet = controller.sheetPresentationController {
                    sheet.detents = detents
                    sheet.prefersGrabberVisible = true
                }
                presentedViewController.present(controller, animated: true, completion: nil)
                
            } else {
                if let sheet = controller.sheetPresentationController {
                    sheet.detents = detents
                    sheet.prefersGrabberVisible = true
                }
                
                navigationController.topViewController?.present(
                    controller,
                    animated: true,
                    completion: nil
                )
            }
            
        case .none:
            break
        }
    }
}
