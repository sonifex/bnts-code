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


// MARK: - App layer API Models ViewModel

// Photo User
protocol PhotoUserViewModeling {
    var id: String { get }
    var username: String { get }
    var bio: String? { get }
    var location: String? { get }
}

struct PhotoUserViewModel: PhotoUserViewModeling {
    var id: String
    var username: String
    var bio: String?
    var location: String?
    
    init(id: String, username: String, bio: String? = nil, location: String? = nil) {
        self.id = id
        self.username = username
        self.bio = bio
        self.location = location
    }
    
    init(user: BNUser) {
        self.init(id: user.id, username: user.username, bio: user.bio, location: user.location)
    }
}


// Photo Sponsor
protocol PhotoSponsorViewModeling {
    var id: String { get }
    var username: String { get }
}

struct PhotoSponsorViewModel: PhotoSponsorViewModeling {
    var id: String
    
    var username: String
    
    init(id: String, username: String) {
        self.id = id
        self.username = username
    }
    
    init(sponsor: BNPhotoSponsor) {
        self.init(id: sponsor.id, username: sponsor.username)
    }
}


// Photo
protocol PhotoViewModeling {
    var id: String { get }
    var title: String { get }
    var imageURL: URL { get }
    var totalLikes: Int { get }
    var isLiked: Bool { get }
    
    var createdAt: Date { get }
    var description: String? { get }
    var altDescription: String? { get}
    
    var sponsor: PhotoSponsorViewModeling? { get }
    var user: PhotoUserViewModeling { get }
    
}

struct PhotoViewModel: PhotoViewModeling & Identifiable {
    let id: String
    let title: String
    let imageURL: URL
    let totalLikes: Int
    let isLiked: Bool
    
    var createdAt: Date
    var description: String?
    var altDescription: String?
    
    var sponsor: PhotoSponsorViewModeling?
    var user: PhotoUserViewModeling
    
    public init(id: String,
                title: String,
                imageURL: URL,
                totalLikes: Int,
                isLiked: Bool,
                createdAt: Date,
                description: String? = nil,
                altDescription: String? = nil,
                sponsor: PhotoSponsorViewModeling? = nil,
                user: PhotoUserViewModeling) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.totalLikes = totalLikes
        self.isLiked = isLiked
        self.createdAt = createdAt
        self.description = description
        self.altDescription = altDescription
        self.sponsor = sponsor
        self.user = user
    }
    
    init(photo: BNPhoto) {
        self.init(id: photo.id,
                  title: photo.slug,
                  imageURL: photo.urls.regular,
                  totalLikes: photo.likes,
                  isLiked: photo.likedByUser,
                  createdAt: photo.createdAt,
                  sponsor: photo.sponsor != nil ? PhotoSponsorViewModel(sponsor: photo.sponsor!) : nil,
                  user: PhotoUserViewModel(user: photo.user))
    }
}


enum APIError: Error {
    case apiError(message: String)
    case unknown
    // TODO: Rest can be added later
    
    init(apiError: BNAPIError) {
        switch apiError {
        case .apiError(let msg):
            self = .apiError(message: msg)
        default:
            self = .unknown
        }
    }
}
