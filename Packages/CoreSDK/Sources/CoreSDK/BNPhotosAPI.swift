//
//  BNPhotosAPI.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation

public protocol BNPhotosAPIType {
    func fetchPhotos(completion: @escaping BNAPICallback<[BNPhoto]>)
    func likePhoto(id: String, completion: @escaping BNAPICallback<BNPhoto>)
    func unLikePhoto(id: String, completion: @escaping BNAPICallback<BNPhoto>)
}

public final class BNPhotosAPI: BNBaseAPI, BNPhotosAPIType {
    public func fetchPhotos(completion: @escaping BNAPICallback<[BNPhoto]>) {
        fetch(of: [BNPhoto].self, target: .photos, completion: completion)
    }
    
    public func likePhoto(id: String, completion: @escaping BNAPICallback<BNPhoto>) {
        fetch(of: BNPhoto.self, target: .likePhoto(id: id), completion: completion)
    }
    
    public func unLikePhoto(id: String, completion: @escaping BNAPICallback<BNPhoto>) {
        fetch(of: BNPhoto.self, target: .unLikePhoto(id: id), completion: completion)
    }
}
