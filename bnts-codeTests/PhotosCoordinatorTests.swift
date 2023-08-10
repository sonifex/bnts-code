//
//  PhotosCoordinatorTests.swift
//  bnts-codeTests
//
//  Created by Soner Güler on 10/08/2023.
//

import XCTest
@testable import bnts_code

class PhotosCoordinatorTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var photosCoordinator: PhotosCoordinator!
    
    override func setUp() {
        super.setUp()
        
        navigationController = UINavigationController()
        photosCoordinator = PhotosCoordinator(navigationControler: navigationController)
    }
    
    override func tearDown() {
        navigationController = nil
        photosCoordinator = nil
        
        super.tearDown()
    }
    
    func testStart() {
        // When
        photosCoordinator.start()
        
        // Then
        XCTAssertEqual(navigationController.viewControllers.count, 1, "Navigation controller should have 1 view controller")
    }
}
