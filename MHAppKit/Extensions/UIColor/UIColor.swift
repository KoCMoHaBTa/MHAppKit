//
//  UIColor.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

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
     
     Creates an instance of the receiver with HEX String value and alpha
     
     - parameter HEX: The HEX value from "000000" to "FFFFFF"
     - parameter alpha: The alpha component value from 0 to 1. Default to 1
     
     - returns: An instance of the receiver or nil if the HEX parameter is invalid.
     
     */
    
    public convenience init?(HEX: String, alpha: CGFloat = 1) {
        
        var HEX = HEX
        var RGB: UInt32 = 0
        
        //remove hash tag from HEX string
        if HEX.characters.first == "#" {
            
            HEX.remove(at: HEX.startIndex)
        }
        
        guard Scanner(string: HEX).scanHexInt32(&RGB) else {
            
            return nil
        }
        
        self.init(RGB: RGB, alpha: alpha)
    }
}

extension UIColor {
    
    ///Represents a color space type
    public enum ColorSpace {
        
        case automatic
        case rgb
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
    
    public func HEX(of colorSpace: ColorSpace = .automatic) -> (HEX: String, alpha: CGFloat)? {
        
        guard let (components, alpha): ([String], CGFloat) = self.components(of: colorSpace) else {
            
            return nil
        }

        let HEX = components.reduce("", { (result, element) -> String in
            
            var result = result
            
            result += element
            
            return result
        })
        
        return (HEX, alpha)
    }
    
    
    ///The HEX representation of the receiver
    public var HEX: String? {
        
        return self.HEX()?.HEX
    }
}
