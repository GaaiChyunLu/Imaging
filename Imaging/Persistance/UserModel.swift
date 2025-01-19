import Foundation
import SwiftData

/// Persistented imaging model.
@Model
final class UserModel {
    /// Model name.
    public var name: String
    /// API key for the model.
    public var apiKey: String?
    
    /// Initialize a new model for persistance.
    public init(name: String, apiKey: String?) {
        self.name = name
        if let apiKey = apiKey {
            self.apiKey = apiKey
        }
    }
}
