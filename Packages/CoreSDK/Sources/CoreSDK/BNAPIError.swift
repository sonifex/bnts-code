//
//  File.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//

import Foundation

public typealias BNAPIResult<T> = Swift.Result<T, BNAPIError>

public typealias BNAPICallback<T> = (BNAPIResult<T>)->Void

public enum BNAPIError: Error, Equatable {
    case cannotMapResponse
    case internetOffline
    case unknown
    case apiError(message: String)
    case notFound
    case unauthorised
}
