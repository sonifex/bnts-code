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
    var loadingPhotoLikeID: String? { get }
    
    var photos: [PhotoViewModel] { get }
    
    func viewDidLoad()
    
    func photoLikeDidTap(photo: PhotoViewModel)
}


final class PhotosViewModel: PhotosViewModeling & ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var loadingPhotoLikeID: String?
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
    
    func photoLikeDidTap(photo: PhotoViewModel) {
        
        // Seems like the endpoint for like/unlike only available for oauth2 authorization.
        // Since this is just a public auth, we need to ignore it for now.
        
//        if photo.isLiked {
//            unlikePhoto(photo: photo)
//        } else {
//            likePhoto(photo: photo)
//        }
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
    
    func likePhoto(photo: PhotoViewModel) {
        loadingPhotoLikeID = photo.id
        service.likePhoto(id: photo.id)
            .receive(on: DispatchQueue.main)
            .catch { [weak self] error -> AnyPublisher<PhotoViewModel, Never> in
                self?.loadingPhotoLikeID = nil
                return Empty().eraseToAnyPublisher()
            }
            .sink(receiveValue: { [weak self] photo in
                self?.loadingPhotoLikeID = nil
                self?.handlePhotoResponse(photo: photo)
            })
            .store(in: &cancellables)
    }
    
    func unlikePhoto(photo: PhotoViewModel) {
        loadingPhotoLikeID = photo.id
        service.unLikePhoto(id: photo.id)
            .receive(on: DispatchQueue.main)
            .catch { [weak self] error -> AnyPublisher<PhotoViewModel, Never> in
                self?.loadingPhotoLikeID = nil
                return Empty().eraseToAnyPublisher()
            }
            .sink(receiveValue: { [weak self] photo in
                self?.loadingPhotoLikeID = nil
                self?.handlePhotoResponse(photo: photo)
            })
            .store(in: &cancellables)
    }
    
    func handlePhotosResponse(photos: [PhotoViewModel]) {
        self.photos = photos
    }
    
    func handlePhotoResponse(photo: PhotoViewModel) {
        guard let index = photos.firstIndex(where: { $0.id == photo.id }) else {
            return
        }
        photos[index] = photo
    }
}


