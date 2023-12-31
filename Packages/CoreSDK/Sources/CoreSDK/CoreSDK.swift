
import Foundation

public enum BNENV {
    case dev
    case prod
    
    var apiBaseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://api.unsplash.com/")!
        case .prod:
            return URL(string: "https://api.unsplash.com/")!
        }
    }
}

public final class CoreSDK {
    
    public var env: BNENV = .dev

    public static let shared = CoreSDK()
    
    // API Types
    public lazy var photosAPI: BNPhotosAPIType = {
        return BNPhotosAPI()
    }()
}
