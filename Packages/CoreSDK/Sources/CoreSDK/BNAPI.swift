//
//  BNAPI.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//
import Foundation
import Moya

public enum BNAPI {
    case photos
    case likePhoto(id: String)
    case unLikePhoto(id: String)
}

extension BNAPI: TargetType {
    public var baseURL: URL {
        CoreSDK.shared.env.apiBaseURL
    }
    
    public var path: String {
        switch self {
        case .photos:
            return "photos"
        case .likePhoto(let id), .unLikePhoto(let id):
            return "photos/\(id)/like"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        case .likePhoto:
            return .post
        case .unLikePhoto:
            return .delete
        }
        
    }
    
    public var task: Task {
        switch self {
            
        default:
            return .requestPlain
        }
        
    }
    
    public var headers: [String : String]? {
        let token = "Twuh1oZWeWFoEjT5S698NcD8latRQzq55CfyYSaQ7Wo"
        return ["Authorization": "Client-ID \(token)"]
    }
}
