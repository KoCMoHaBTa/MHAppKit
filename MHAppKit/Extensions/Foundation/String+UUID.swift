//
//  String+UUID.swift
//  MHAppKit
//
//  Created by Milen Halachev on 28.06.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension String {
    
    ///Generates a new UUID string
    public static var uuid: String {
        
        return UUID().uuidString
    }
}
