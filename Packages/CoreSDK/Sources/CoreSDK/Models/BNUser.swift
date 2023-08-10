//
//  BNUser.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation

public final class BNUserSocial: Decodable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?
    let paypalEmail: String?
}

public final class BNUserProfileImage: Decodable {
    public let small: String
    public let medium: String
    public let large: String
}

public final class BNUser: Decodable {
    public let id: String
    public let updatedAt: Date
    public let username: String
    public let name: String
    public let firstName: String
    public let lastName: String?
    public let twitterUsername: String?
    public let bio: String?
    public let profileImage: BNUserProfileImage
    public let instagramUsername: String?
    public let totalCollections: Int
    public let totalLikes: Int
    public let totalPhotos: Int
    public let acceptedTos: Bool
    public let forHire: Bool
    public let social: BNUserSocial?
    public let location: String?
}
