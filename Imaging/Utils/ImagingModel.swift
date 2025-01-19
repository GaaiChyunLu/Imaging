import Foundation
import SwiftUI

/// Imaging model information.
public struct ImagingModel {
    /// Model name.
    public var name: String
    /// Company that created the model.
    public var company: String
    /// Wiki page URL for the model.
    public var wikiUrl: String
    /// Model description in detail view.
    public var description: String
    /// Model icon resuorce.
    public var iconResource: ImageResource
    /// Model image resource for detail view.
    public var detailImage: ImageResource
    /// Is the model free to use.
    public var isFree: Bool
    /// Is the model requires an API key.
    public var needApiKey: Bool
    /// Custom hex color values for model card.
    public var customHexColor: ModelCardCustomHexColor
    
    /// Pollinations imaging model.
    ///
    /// See [Pollinations GitHub page](https://github.com/pollinations/pollinations/?tab=readme-ov-file#readme) for more information.
    public static let pollinations = ImagingModel(name: "Pollinations",
                                                  company: "Pollinations.AI",
                                                  wikiUrl: "https://github.com/pollinations/pollinations",
                                                  description: "Pollinations.AI is an AI-driven platform that generates unique visual content from user prompts. It caters to artists and designers, making it easy to transform ideas into stunning images. By utilizing advanced machine learning, it offers a fresh way to explore creativity in digital art.",
                                                  iconResource: .pollinationsIcon,
                                                  detailImage: .pollinationsDetail,
                                                  isFree: true,
                                                  needApiKey: false,
                                                  customHexColor: ModelCardCustomHexColor(backgroundHexColor: ImagingHexColor.green,
                                                                                          companyHexColor: ImagingHexColor.lightCyan))
}

/// Custom hex color values for model card.
public struct ModelCardCustomHexColor {
    /// Model card background hex color.
    public var backgroundHexColor: UInt
    /// Company text hex color.
    public var companyHexColor: UInt
}
