//
//  AppCoordinatorTests.swift
//  bnts-codeTests
//
//  Created by Soner Güler on 10/08/2023.
//

import XCTest
@testable import bnts_code

class AppCoordinatorTests: XCTestCase {
    
    var window: UIWindow!
    var appCoordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window)
    }
    
    override func tearDown() {
        window = nil
        appCoordinator = nil
        
        super.tearDown()
    }
    
    func testStart() {
        // Given
        
        // When
        appCoordinator.start()
        
        // Then
        XCTAssertNotNil(window.rootViewController)
    }
}
