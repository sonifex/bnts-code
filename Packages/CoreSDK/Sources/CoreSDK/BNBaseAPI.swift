//
//  File.swift
//  
//
//  Created by Soner Güler on 10/08/2023.
//


import Foundation
import Combine
import Moya
import CombineMoya

public extension Notification.Name {
    static let unauthorisedUserDetected = Notification.Name("unauthorisedUserDetected")
}

public class BNBaseAPI {
    
    lazy var cancellables = Set<AnyCancellable>()
    
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    var provider = MoyaProvider<BNAPI>()
    
    func logError(tag: String, error: Error) {
        debugPrint("⛔️ ERROR: Service: [\(tag)] - \(error.localizedDescription)")
        debugPrint("⛔️ ERROR: Service Detail: [\(tag)] - \(error)")
    }
    
    func logInfo(tag: String, message: String) {
        debugPrint("ℹ️ INFO: [\(tag)] - \(message)")
    }
    
    func logEvent(name: String, params: [String: String]) {
        debugPrint("ℹ️ EVENT: [\(name)] - \(params)")
    }
    
    func fetch<T: Decodable>(of type: T.Type, target: BNAPI, completion: @escaping BNAPICallback<T>) {
        logInfo(tag: "API", message: "[\(target.method.rawValue)]\(target.path)")
        provider.requestPublisher(target)
            .sink { [weak self] completionn in
                switch completionn {
                case .failure(let error):
                    
                    self?.logError(tag: target.path, error: error)
                    self?.logEvent(name: "API_ERROR", params: [
                        "path": target.path,
                        "method": target.method.rawValue,
                        "err": error.localizedDescription
                    ])
                    
                    switch error.errorCode {
                    case 6:
                        completion(.failure(.internetOffline))
                    default:
                        completion(.failure(.unknown))
                    }
                default:
                    break
                }
            } receiveValue: { [weak self] response in
                do {
                    
                    if response.statusCode == 400 {
                        throw BNAPIError.unknown
                    }
                    
                    if response.statusCode == 404 {
                        throw BNAPIError.notFound
                    }
                    
                    if response.statusCode == 401 || response.statusCode == 403 {
                        throw BNAPIError.unauthorised
                    }
                    
                    guard let decoder = self?.jsonDecoder else {
                        throw BNAPIError.unknown
                    }
                    
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let json = try filteredResponse.map(type.self, using: decoder)
                    completion(.success(json))
                    
                } catch {
                    
                    if let qmError = error as? BNAPIError {
                        completion(.failure(qmError))
                        return
                    }
                    
                    self?.logError(tag: "JSON Mapping", error: error)
                    self?.logEvent(name: "JSON_MAPPING_ERROR", params: [
                        "err": error.localizedDescription
                    ])
                    
                    completion(.failure(.cannotMapResponse))
                }
            }
            .store(in: &cancellables)
    }
}

//
//extension Formatter {
//    static let iso8601withFractionalSeconds: ISO8601DateFormatter = {
//        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//        return formatter
//    }()
//    static let iso8601: ISO8601DateFormatter = {
//        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions = [.withInternetDateTime]
//        return formatter
//    }()
//}
//
//extension JSONDecoder.DateDecodingStrategy {
//    static let customISO8601 = custom {
//        let container = try $0.singleValueContainer()
//        let string = try container.decode(String.self)
//        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
//            return date
//        }
//        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
//    }
//}
//
//extension JSONEncoder.DateEncodingStrategy {
//    static let customISO8601 = custom {
//        var container = $1.singleValueContainer()
//        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
//    }
//}
