//
//  MockPhotosService.swift
//  bnts-codeTests
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation
@testable import bnts_code
import Combine

class MockPhotosService: PhotosServicing {
    var photos: [PhotoViewModel] = []
    
    func fetchPhotos() -> Future<[PhotoViewModel], APIError> {
        return Future<[PhotoViewModel], APIError> { promise in
            promise(.success(self.photos))
        }
    }
    
    func likePhoto(id: String) -> Future<bnts_code.PhotoViewModel, bnts_code.APIError> {
        return Future<PhotoViewModel, APIError> { promise in
            promise(.failure(.unknown))
        }
    }
    
    func unLikePhoto(id: String) -> Future<bnts_code.PhotoViewModel, bnts_code.APIError> {
        return Future<PhotoViewModel, APIError> { promise in
            promise(.failure(.unknown))
        }
    }
}
