//
//  Data+TemporaryFile.swift
//  MHAppKit
//
//  Created by Milen Halachev on 18.01.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

@available(watchOS 3.0, *)
@available(tvOS 10.0, *)
@available(OSX 10.12, *)
@available(iOS 10.0, *)
extension Data {
    
    public func writeToTemporaryURL(withExtension ext: String? = nil) throws -> URL {
        
        return try self.writeToTemporaryURL(withExtension: ext, options: [])
    }
    
    public func writeToTemporaryURL(withExtension ext: String? = nil, options: Data.WritingOptions) throws -> URL {
        
        var url = FileManager.default.temporaryDirectory.appendingPathComponent(.uuid)
        
        if let ext = ext {
            
            url.appendPathExtension(ext)
        }
        
        try self.write(to: url, options: options)
        return url
    }
}
