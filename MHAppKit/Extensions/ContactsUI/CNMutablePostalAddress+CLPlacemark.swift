//
//  CNMutablePostalAddress+CLPlacemark.swift
//  MHAppKit
//
//  Created by Milen Halachev on 28.06.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if canImport(Contacts)
import Foundation
import Contacts
import CoreLocation

@available(OSX 10.11, *)
@available(iOS 9.0, *)
extension CNMutablePostalAddress {
    
    ///Creates an intance of the receiver by retrieving information from a placemark
    public convenience init(placemark: CLPlacemark) {
        
        self.init()
        
        if let street = placemark.thoroughfare {
            
            self.street = street
        }
        
        if let city = placemark.locality {
            
            self.city = city
        }
        
        if let state = placemark.administrativeArea {
            
            self.state = state
        }
        
        if let postalCode = placemark.postalCode {
            
            self.postalCode = postalCode
        }
        
        if let country = placemark.country {
            
            self.country = country
        }
        
        if let isoCountryCode = placemark.isoCountryCode {
            
            self.isoCountryCode = isoCountryCode
        }
        
        if #available(iOS 10.3, *), #available(OSX 10.12.4, *), #available(watchOS 3.3, *) {
            
            if let subAdministrativeArea = placemark.subAdministrativeArea {
                
                self.subAdministrativeArea = subAdministrativeArea
            }
            
            if let subLocality = placemark.subLocality {
                
                self.subLocality = subLocality
            }
        }
    }
}
#endif
