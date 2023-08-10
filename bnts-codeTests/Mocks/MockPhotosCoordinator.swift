//
//  MockPhotosCoordinator.swift
//  bnts-codeTests
//
//  Created by Soner Güler on 10/08/2023.
//

import UIKit
@testable import bnts_code

class MockPhotosCoordinator: PhotosCoordinating {
    var navigationController: UINavigationController = UINavigationController()
    var isStartCalled = false
    var photoID: String?
    
    func start() {
        isStartCalled = true
    }
    
    func photoDidTap(photo: bnts_code.PhotoViewModeling) {
        photoID = photo.id
    }
}
