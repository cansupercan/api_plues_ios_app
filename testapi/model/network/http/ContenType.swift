//
//  ContenType.swift
//  testapi
//
//  Created by imac 1682's MacBook Pro on 2024/9/13.
//

import Foundation

enum ContenType:String, CustomStringConvertible{
    case json = "application/json"
    case xml = "application/xml"
    case textPlain = "text/plain"
    case x_ww_from_urlencoded = "application/x_ww_from_urlencoded"
    var description: String{
        let base = "HTTP Content-Type"
        return base + self.rawValue
    }
}
