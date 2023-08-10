//
//  PhotosService.swift
//  bnts-code
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation
import CoreSDK
import Combine

protocol PhotosServicing {
    func fetchPhotos() -> Future<[PhotoViewModel], APIError>
    func likePhoto(id: String) -> Future<PhotoViewModel, APIError>
    func unLikePhoto(id: String) -> Future<PhotoViewModel, APIError>
}

struct PhotosService: PhotosServicing {
    private let photosAPI: BNPhotosAPIType
    
    init(photosAPI: BNPhotosAPIType = CoreSDK.shared.photosAPI) {
        self.photosAPI = photosAPI
    }
    
    func fetchPhotos() -> Future<[PhotoViewModel], APIError> {
        return Future<[PhotoViewModel], APIError> { promise in
            photosAPI.fetchPhotos { result in
                switch result {
                case let.failure(err):
                    promise(.failure(APIError(apiError: err)))
                case let .success(photos):
                    promise(.success(photos.map { PhotoViewModel(photo: $0) }))
                }
            }
        }
    }
    
    func likePhoto(id: String) -> Future<PhotoViewModel, APIError> {
        return Future<PhotoViewModel, APIError> { promise in
            photosAPI.likePhoto(id: id) { result in
                switch result {
                case let.failure(err):
                    promise(.failure(APIError(apiError: err)))
                case let .success(photo):
                    promise(.success(PhotoViewModel(photo: photo)))
                }
            }
        }
    }
    func unLikePhoto(id: String) -> Future<PhotoViewModel, APIError> {
        return Future<PhotoViewModel, APIError> { promise in
            photosAPI.unLikePhoto(id: id) { result in
                switch result {
                case let.failure(err):
                    promise(.failure(APIError(apiError: err)))
                case let .success(photo):
                    promise(.success(PhotoViewModel(photo: photo)))
                }
            }
        }
    }
}


struct PhotoViewModel: Identifiable {
    let id: String
    let title: String
    let imageURL: URL
    let totalLikes: Int
    let isLiked: Bool
    
    init(photo: BNPhoto) {
        self.id = photo.id
        self.title = photo.description ?? ""
        self.imageURL = photo.urls.regular
        self.totalLikes = photo.likes
        self.isLiked = photo.likedByUser
    }
}


struct APIError: Error {
    
    init(apiError: BNAPIError) {
        
    }
}
