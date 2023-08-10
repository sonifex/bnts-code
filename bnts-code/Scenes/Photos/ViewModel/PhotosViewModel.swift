//
//  PhotosViewModeling.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation
import os
import Combine

protocol PhotosViewModeling {
    var isLoading: Bool { get }
    var photos: [PhotoViewModel] { get }
    
    func viewDidLoad()
}


final class PhotosViewModel: PhotosViewModeling & ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var photos: [PhotoViewModel] = []
    
    private let service: PhotosServicing
    
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var logger = Logger(for: type(of: self))
    
    init(service: PhotosServicing = PhotosService()) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchPhotos()
    }
}


private extension PhotosViewModel {
    func fetchPhotos() {
        isLoading = true
        
        service.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .catch { [weak self] error -> AnyPublisher<[PhotoViewModel], Never> in
                self?.isLoading = false
                return Empty().eraseToAnyPublisher()
            }
            .sink(receiveValue: { [weak self] photos in
                self?.isLoading = false
                self?.handlePhotosResponse(photos: photos)
            })
            .store(in: &cancellables)
    }
    
    func handlePhotosResponse(photos: [PhotoViewModel]) {
        self.photos = photos
    }
}


