//
//  Codable+JSON.swift
//  MHAppKit
//
//  Created by Milen Halachev on 27.09.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension Decodable {
    
    public init?(json data: Data?) {
        
        guard
        let data = data
        else {
            
            return nil
        }
        
        do {
           
            let result = try JSONDecoder().decode(Self.self, from: data)
            self = result
        }
        catch {
            
            return nil
        }
    }
    
    public init?(json string: String?) {
        
        guard
        let data = string?.data(using: .utf8)
        else {
            
            return nil
        }
        
        self.init(json: data)
    }

    public init?(json object: Any?) {
        
        guard
        let object = object,
        let data = try? JSONSerialization.data(withJSONObject: object, options: [])
        else {
            
            return nil
        }
        
        self.init(json: data)
    }
}

extension Encodable {
    
    public func json() -> String? {

        guard
        let data: Data = self.json()
        else {
            
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }

    public func json() -> Data? {

        do {
            
            return try JSONEncoder().encode(self)
        }
        catch {
            
            return nil
        }
    }

    public func json() -> Any? {

        guard
        let data: Data = self.json()
        else {
            
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
}

