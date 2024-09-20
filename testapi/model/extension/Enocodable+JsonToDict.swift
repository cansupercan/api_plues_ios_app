//
//  Enocodable+JsonToDict.swift
//  testapi
//
//  Created by imac 1682's MacBook Pro on 2024/9/13.
//

import Foundation
extension Encodable{
    func toDidctionary()throws -> [String:Any]{
        let data = try JSONEncoder().encode(self)
        guard let dicationary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)as?[String:Any] else{
            throw NSError()
        }
        return dicationary
    }
}
