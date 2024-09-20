//
//  headerfield.swift
//  testapi
//
//  Created by imac 1682's MacBook Pro on 2024/9/13.
//

import Foundation

public enum headerfield : String{
    
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case userkey = "User-Key"
    case cokie = "Cokie"
    
//     var description:String{
//        let base = "HTTP Header Fields: "
//        return base + self.rawValue
//    }
}
