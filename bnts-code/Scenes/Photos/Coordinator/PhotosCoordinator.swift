//
//  PhotosCoordinator.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import UIKit

protocol PhotosCoordinating: FlowCoordinating {
    func photoDidTap(photo: PhotoViewModeling)
}

final class PhotosCoordinator {
    var navigationController: UINavigationController
    
    
    init(navigationControler: UINavigationController) {
        self.navigationController = navigationControler
    }
    
    func start() {
        let viewModel = PhotosViewModel()
        viewModel.coordinator = self
        let vc = PhotosViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}

extension PhotosCoordinator: PhotosCoordinating {
    func photoDidTap(photo: PhotoViewModeling) {
        guard let photoVM = photo as? PhotoViewModel else { return }
        
        let vm = PhotoDetailViewModel(photo: photoVM)
        let vc = PhotoDetailViewController(viewModel: vm)
        navigate(type: .sheet(vc, [.medium(), .large()]))
    }
}
