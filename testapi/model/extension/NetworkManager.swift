import UIKit

//建立和發送網絡請求，並處理回應。
class weatherRequest {
    
    // 發送網絡請求並解析回應
    public func requestData<E, D>(method:  RequestMethod,
                                  path: networkPath.ApiPath,
                                  parameters: E) async throws -> D where E: Encodable, D: Decodable {
        let urlRequest = handleHTTPMethod(method: method, path: path, parameters: parameters) // 建立 URLRequest
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest) // 發送請求並獲取回應
            guard let response = (response as? HTTPURLResponse) else {
                throw responsestatus.invalidResponse // 檢查回應是否有效
            }
            
            let statusCode = response.statusCode
            guard (200 ... 299).contains(statusCode) else {
                // 處理不同的 HTTP 狀態碼
                switch statusCode {
                case 400:
                    throw responsestatus.badRequest
                case 401:
                    throw responsestatus.authorizationError
                case 404:
                    throw  responsestatus.notFound
                case 500:
                    throw responsestatus.internalError
                case 502:
                    throw responsestatus.badGetway
                case 503:
                    throw responsestatus.severUnavailable
                default:
                    throw responsestatus.invalidResponse
                }
            }
            
            do{
                let result = try JSONDecoder().decode(D.self, from: data) // 解析 JSON 回應
                printNetworkProgress(urlRequest: urlRequest, parameters: parameters, results: result)
                return result
            } catch {
                throw responsestatus.jsonDecodeFaild(error as! DecodingError) }// 處理 JSON 解析錯誤
        }catch {
            print(error.localizedDescription)
            throw responsestatus.unknowError(error) // 處理未知錯誤
        }
    }
    
    // 處理 HTTP 方法，根據不同的 HTTP 方法和參數建立 URLRequest
    private func handleHTTPMethod<E: Encodable>(method: RequestMethod,
                                                path: networkPath.ApiPath,
                                                parameters: E?) -> URLRequest {
        
        let baseURL = networkPath.httpsBaseUrl + networkPath.severAress // 基礎 URL
        let url = URL(string: baseURL + path.rawValue)! // 完整 URL
        var urlReguest = URLRequest(url:url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10) // 建立 URLRequest
        let httpType = ContenType.json.rawValue
        urlReguest.allHTTPHeaderFields = [headerfield.contentType.rawValue : httpType] // 設定 Header
        
        urlReguest.httpMethod = method.rawValue
        
        let dict1 = try? parameters?.toDidctionary()
        switch method {
        case .get:
            let parameters = dict1 as? [String : String]
            urlReguest.url = requestWithURL(urlString:urlReguest.url?.absoluteString ?? "", parameters: parameters ?? [:])
        default:
            urlReguest.httpBody = try? JSONSerialization.data(withJSONObject: dict1 ?? [:], options: .prettyPrinted)
            
        }
        return urlReguest
    }
    
    private func requestWithURL(urlString: String, parameters: [String : String]?) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        urlComponents.queryItems = []
        parameters?.forEach { (key, value) in
            urlComponents.queryItems?.append(URLQueryItem(name: key,value:value))
        }
        return urlComponents.url
    }
    
    private func printNetworkProgress<E, D>(urlRequest: URLRequest,
                                            parameters: E,
                                            results: D) where E: Encodable, D: Decodable {
        #if DEBUG
        print("======================================================")
        print("- URL: \(urlRequest.url?.absoluteString ?? "")")
        print("- Header: \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("------------------Request-----------------------------")
        print(parameters)
        print("------------------Response----------------------------")
        print(results)
        print("======================================================")
        #endif
        
    }
}
