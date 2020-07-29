//
//  Loopable.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/30/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

protocol Loopable{
    func allKeysValues() throws -> [String:Any?];
}

extension Loopable{
    func allKeysValues() throws -> [String:Any?]{
        var result:[String:Any?] = [:]
        var mirror = Mirror(reflecting: self)
        
        guard let style = mirror.displayStyle , style == .struct || style == .class else{
            throw NSError()
        }
        
        for(prop,value) in mirror.children{
            if let key = prop{
              result[key] = value
            }
        }
        
        return result
    }
}
