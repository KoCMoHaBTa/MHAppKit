//
//  CLLocation+CGImagePropertyGPS.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import ImageIO
import CoreLocation

//https://stackoverflow.com/questions/9006759/how-to-write-exif-metadata-to-an-image-not-the-camera-roll-just-a-uiimage-or-j
public extension CLLocation {
    
    private static let formatter: DateFormatter = { () -> DateFormatter in
        
        var formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH:mm:ss.SS"
        
        return formatter
    }()
    
    ///The GPS media metadata key
    public static let CGImagePropertyGPSKey = kCGImagePropertyGPSDictionary as String
    
    ///Returns the GPS media metadata value that can be added to an image
    public var CGImagePropertyGPSValue: [AnyHashable: Any] {
        
        return [
            kCGImagePropertyGPSLatitude as String: fabs(self.coordinate.latitude),
            kCGImagePropertyGPSLatitudeRef as String: ((self.coordinate.latitude >= 0) ? "N" : "S"),
            kCGImagePropertyGPSLongitude as String: fabs(self.coordinate.longitude),
            kCGImagePropertyGPSLongitudeRef as String: ((self.coordinate.longitude >= 0) ? "E" : "W"),
            kCGImagePropertyGPSTimeStamp as String: type(of: self).formatter.string(from: self.timestamp),
            kCGImagePropertyGPSAltitude as String: fabs(self.altitude)
        ]
    }
}
