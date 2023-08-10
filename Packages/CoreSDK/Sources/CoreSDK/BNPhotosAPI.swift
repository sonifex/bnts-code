//
//  BNPhotosAPI.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation

public protocol BNPhotosAPIType {
    func fetchPhotos(completion: @escaping BNAPICallback<[BNPhoto]>)
}

public final class BNPhotosAPI: BNBaseAPI, BNPhotosAPIType {
    public func fetchPhotos(completion: @escaping BNAPICallback<[BNPhoto]>) {
        fetch(of: [BNPhoto].self, target: .photos, completion: completion)
    }
}
