//
//  responsestatus.swift
//  testapi
//
//  Created by imac 1682's MacBook Pro on 2024/9/13.
//

import Foundation
enum responsestatus:Error{
    case unknowError(Error)
    case connectionError
    case invalidResponse
    case jsonDecodeFaild(DecodingError)
    case invalidURLRequest
    case authorizationError
    case notFound
    case internalError
    case badRequest
    case badGetway
    case severError
    case severUnavailable
}
