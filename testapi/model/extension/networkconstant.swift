//
//  networkconstant.swift
//  testapi
//
//  Created by imac 1682's MacBook Pro on 2024/9/13.
//

import Foundation
enum networkPath{
    static let httpBaseUrl = "http://"
    static let httpsBaseUrl = "https://"
    
    static let severAress = "opendata.cwa.gov.tw/api"
    enum ApiPath:String{
        case thirtySixHour = "/v1/rest/datastore/F-C0032-001"
    }
}
