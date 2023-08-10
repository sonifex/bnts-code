//
//  BNPhoto.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation

public final class BNPhotoUrls: Decodable {
    public let raw: URL
    public let full: URL
    public let regular: URL
    public let small: URL
    public let thumb: URL
    public let smallS3: URL
}

public final class BNPhotoLinks: Decodable {
    public let `self`: URL
    public let html: URL
    public let download: URL
    public let downloadLocation: URL
}

public final class BNPhoto: Decodable {
    public let id: String
    public let slug: String
    public let createdAt: Date
    public let updatedAt: Date
    public let color: String
    public let description: String?
    public let altDescription: String?
    
    public let urls: BNPhotoUrls
    public let links: BNPhotoLinks
    public let likes: Int
    public let likedByUser: Bool
    
}
