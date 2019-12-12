//
//  UIColor+HEX.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

#if canImport(UIKit)
import Foundation
import UIKit

extension UIColor {
    
    ///The maximum RGB value - 24bit unsinged integer
    private static let RGBMaxValue: UInt32 = 16777215
    
    /**
     
     Creates an instance of the receiver with 8bit RGB component values and alpha.
     
     - parameter R: The red component value from 0 to 255
     - parameter G: The green component value from 0 to 255
     - parameter B: The blue component value from 0 to 255
     - parameter alpha: The alpha component value from 0 to 1. Default to 1
     
     */
    
    public convenience init(R: UInt8, G: UInt8, B: UInt8, alpha: CGFloat = 1) {
        
        let red = CGFloat(R)/CGFloat(UInt8.max)
        let green = CGFloat(G)/CGFloat(UInt8.max)
        let blue = CGFloat(B)/CGFloat(UInt8.max)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(R: UInt8, G: UInt8, B: UInt8, A: UInt8) {
        
        let red = CGFloat(R)/CGFloat(UInt8.max)
        let green = CGFloat(G)/CGFloat(UInt8.max)
        let blue = CGFloat(B)/CGFloat(UInt8.max)
        let alpha = CGFloat(A)/CGFloat(UInt8.max)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     
     Creates an instance of the receiver with 24bit RGB value and alpha
     
     - parameter RGB: The RGB value from 0 to 16777215
     - parameter alpha: The alpha component value from 0 to 1. Default to 1
     
     */
    
    public convenience init?(RGB: UInt32, alpha: CGFloat = 1) {
        
        guard RGB <= UIColor.RGBMaxValue else {
            
            return nil
        }
        
        let R = UInt8((RGB & 0xFF0000) >> 16)
        let G = UInt8((RGB & 0x00FF00) >> 8)
        let B = UInt8((RGB & 0x0000FF) >> 0)
        
        self.init(R: R, G: G, B: B, alpha: alpha)
    }
    
    /**
     
     Creates an instance of the receiver with 32bit RGBA value
     
     - parameter RGBA: The RGBA value from 0 to 4294967295
     
     */
    
    public convenience init(RGBA: UInt32) {
        
        let R = UInt8((RGBA & 0xFF000000) >> 24)
        let G = UInt8((RGBA & 0x00FF0000) >> 16)
        let B = UInt8((RGBA & 0x0000FF00) >> 8)
        let A = UInt8((RGBA & 0x000000FF) >> 0)
        
        self.init(R: R, G: G, B: B, A: A)
    }
    
    /**
     
     Creates an instance of the receiver with 32bit ARGB value
     
     - parameter ARGB: The ARGB value from 0 to 4294967295
     
     */
    
    public convenience init(ARGB: UInt32) {
        
        let A = UInt8((ARGB & 0xFF000000) >> 24)
        let R = UInt8((ARGB & 0x00FF0000) >> 16)
        let G = UInt8((ARGB & 0x0000FF00) >> 8)
        let B = UInt8((ARGB & 0x000000FF) >> 0)
        
        self.init(R: R, G: G, B: B, A: A)
    }
    
    /**
     
     Creates an instance of the receiver with RGB HEX String value and alpha
     
     - parameter HEX: The RGB HEX value from "000000" to "FFFFFF"
     - parameter alpha: The alpha component value from 0 to 1. Default to 1
     
     - returns: An instance of the receiver or nil if the HEX parameter is invalid.
     
     */
    
    @available(*, deprecated, message: "Use init?(RGB:alpha:)")
    public convenience init?(HEX: String, alpha: CGFloat = 1) {
        
        self.init(RGB: HEX, alpha: alpha)
    }
    
    /**
     
     Creates an instance of the receiver with HEX String value and alpha
     
     - parameter RGB: The RGB HEX value from "000000" to "FFFFFF"
     - parameter alpha: The alpha component value from 0 to 1. Default to 1
     
     - returns: An instance of the receiver or nil if the RGB parameter is invalid.
     
     */
    
    public convenience init?(RGB HEX: String, alpha: CGFloat = 1) {
        
        guard let RGB = UInt32(convertingFromHEX: HEX) else {
            
            return nil
        }
        
        self.init(RGB: RGB, alpha: alpha)
    }
    
    /**
     
     Creates an instance of the receiver with HEX String value and alpha
     
     - parameter RGBA: The RGBA HEX value from "00000000" to "FFFFFFFF"
     
     - returns: An instance of the receiver or nil if the RGBA parameter is invalid.
     
     */
    
    public convenience init?(RGBA HEX: String) {
        
        guard let RGBA = UInt32(convertingFromHEX: HEX) else {
            
            return nil
        }
        
        self.init(RGBA: RGBA)
    }
    
    /**
     
     Creates an instance of the receiver with HEX String value and alpha
     
     - parameter ARGB: The ARGB HEX value from "00000000" to "FFFFFFFF"
     
     - returns: An instance of the receiver or nil if the ARGB parameter is invalid.
     
     */

    public convenience init?(ARGB HEX: String) {
        
        guard let ARGB = UInt32(convertingFromHEX: HEX) else {
            
            return nil
        }
        
        self.init(ARGB: ARGB)
    }
}

extension UIColor {
    
    ///Represents a color space type
    public enum ColorSpace {
        
        case automatic //rgb or hsb or white
        case rgb
        case rgba //rgb that inclues the alpha as the last component.
        case argb //rgb that inclues the alpha as the first component.
        case hsb
        case white
    }
    
    /**
     
     Retrieves the components of the receiver for a given color space
     
     - parameter colorSpace: A color space into which to return the compoents. Default to Automatic in the following order - RGB, HSB, White
     
     - returns: A tuple containing the receiver's compoents and alpha or nil of the color is using an unknown color space. The components value is from 0 to 1. The alpha value is from 0 to 1.
     
     */
    
    public func components(of colorSpace: ColorSpace = .automatic) -> (components: [CGFloat], alpha: CGFloat)? {
        
        switch colorSpace {
            
            case .automatic:
            
                return self.components(of: .rgb)
                    ?? self.components(of: .hsb)
                    ?? self.components(of: .white)
            
            case .rgb:
                
                var R: CGFloat = 0
                var G: CGFloat = 0
                var B: CGFloat = 0
                var A: CGFloat = 0
                
                guard self.getRed(&R, green: &G, blue: &B, alpha: &A) else {
                    
                    return nil
                }
            
                return ([R, G, B], A)
            
            case .rgba:
                
                var R: CGFloat = 0
                var G: CGFloat = 0
                var B: CGFloat = 0
                var A: CGFloat = 0
                
                guard self.getRed(&R, green: &G, blue: &B, alpha: &A) else {
                    
                    return nil
                }
                
                return ([R, G, B, A], A)
            
            case .argb:
                
                var R: CGFloat = 0
                var G: CGFloat = 0
                var B: CGFloat = 0
                var A: CGFloat = 0
                
                guard self.getRed(&R, green: &G, blue: &B, alpha: &A) else {
                    
                    return nil
                }
                
                return ([A, R, G, B], A)
            
            case .hsb:
            
                var H: CGFloat = 0
                var S: CGFloat = 0
                var B: CGFloat = 0
                var A: CGFloat = 0
                
                guard self.getHue(&H, saturation: &S, brightness: &B, alpha: &A) else {
                    
                    return nil
                }
                
                return ([H, S, B], A)
            
            case .white:
            
                var W: CGFloat = 0
                var A: CGFloat = 0
                
                guard self.getWhite(&W, alpha: &A) else {
                    
                    return nil
                }
                
                return ([W], A)
        }
    }
    
    /**
     
     Retrieves the components of the receiver for a given color space
     
     - parameter colorSpace: A color space into which to return the compoents. Default to Automatic in the following order - RGB, HSB, White
     
     - returns: A tuple containing the receiver's compoents and alpha or nil of the color is using an unknown color space. The components value is from 0 to 255. The alpha value is from 0 to 1.
     
     */
    
    public func components(of colorSpace: ColorSpace = .automatic) -> (components: [UInt8], alpha: CGFloat)? {
        
        guard let (c, alpha): ([CGFloat], CGFloat) = self.components(of: colorSpace) else {
            
            return nil
        }
        
        let components = c.map { (component) -> UInt8 in
            
            return UInt8(component * CGFloat(UInt8.max))
        }
        
        return (components, alpha)
    }
    
    /**
     
     Retrieves the components of the receiver for a given color space
     
     - parameter colorSpace: A color space into which to return the compoents. Default to Automatic in the following order - RGB, HSB, White
     
     - returns: A tuple containing the receiver's compoents and alpha or nil of the color is using an unknown color space. The components value is from "00" to "FF". The alpha value is from 0 to 1.
     
     */
    
    public func components(of colorSpace: ColorSpace = .automatic) -> (components: [String], alpha: CGFloat)? {
        
        guard let (c, alpha): ([UInt8], CGFloat) = self.components(of: colorSpace) else {
            
            return nil
        }
        
        let components = c.map { (component) -> String in
            
            return String(format: "%.2X", component)
        }
        
        return (components, alpha)
    }
    
    /**
     
     Retrieves the components of the receiver for a given color space
     
     - parameter colorSpace: A color space into which to return the compoents. Default to Automatic in the following order - RGB, HSB, White
     
     - returns: A tuple containing the receiver's HEX and alpha or nil of the color is using an unknown color space. The alpha value is from 0 to 1.
     
     */
    
    public func HEX(of colorSpace: ColorSpace = .automatic, includeHashtag: Bool = true) -> (HEX: String, alpha: CGFloat)? {
        
        guard let (components, alpha): ([String], CGFloat) = self.components(of: colorSpace) else {
            
            return nil
        }

        let HEX = components.reduce(includeHashtag ? "#" : "", { (result, element) -> String in
            
            var result = result
            
            result += element
            
            return result
        })
        
        return (HEX, alpha)
    }
    
    
    ///The HEX representation of the receiver
    @available(*, deprecated, message: "Use RGB instead.")
    public var HEX: String? {
        
        return self.HEX()?.HEX
    }
    
    ///The RGB HEX representation of the receiver
    public var RGB: String? {
        
        return self.HEX(of: .rgb)?.HEX
    }
    
    ///The RGBA HEX representation of the receiver
    public var RGBA: String? {
        
        return self.HEX(of: .rgba)?.HEX
    }
    
    ///The ARGB HEX representation of the receiver
    public var ARGB: String? {
        
        return self.HEX(of: .argb)?.HEX
    }
}

extension UInt32 {
    
    fileprivate init?(convertingFromHEX HEX: String) {
        
        var HEX = HEX
        var result: UInt32 = 0
        
        //remove hash tag from HEX string
        if HEX.first == "#" {
            
            HEX.remove(at: HEX.startIndex)
        }
        
        guard Scanner(string: HEX).scanHexInt32(&result) else {
            
            return nil
        }
        
        self = result
    }
}
#endif
