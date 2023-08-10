//
//  PhotosViewModelTests.swift
//  bnts-codeTests
//
//  Created by Soner Güler on 10/08/2023.
//
import XCTest
import Combine
@testable import bnts_code

class PhotosViewModelTests: XCTestCase {
    
    var viewModel: PhotosViewModel!
    var mockService: MockPhotosService!
    var mockCoordinator: MockPhotosCoordinator!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        mockService = MockPhotosService()
        mockCoordinator = MockPhotosCoordinator()
        viewModel = PhotosViewModel(service: mockService)
        viewModel.coordinator = mockCoordinator
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockCoordinator = nil
        cancellables.removeAll()
        
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // Given
        let photo = PhotoViewModel(id: "-1",
                                   title: "photo 1",
                                   imageURL: URL(string: "http://placekitten.com/200/300")!,
                                   totalLikes: 23,
                                   isLiked: true,
                                   createdAt: .now, user: PhotoUserViewModel(id: "33", username: "username"))
        mockService.photos = [photo]
        
        let exp = expectation(description: "photos loaded")
        
        viewModel.$photos
            .dropFirst()
            .sink { photos in
                XCTAssertEqual(photos.count, 1, "Photos should be loaded")
                XCTAssertEqual(photos.first?.id, "-1")
                exp.fulfill()
            }
            .store(in: &cancellables)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 5)

        XCTAssertTrue(viewModel.isLoading == false, "isLoading should be false")
    }
    
    func testPhotoDidTap() {
        // Given
        let photo = PhotoViewModel(id: "-1",
                                   title: "photo 1",
                                   imageURL: URL(string: "http://placekitten.com/200/300")!,
                                   totalLikes: 23,
                                   isLiked: true,
                                   createdAt: .now, user: PhotoUserViewModel(id: "33", username: "username"))
        
        // When
        viewModel.photoDidTap(photo: photo)
        
        // Then
        XCTAssertEqual(mockCoordinator.photoID, "-1")
    }
    
}
