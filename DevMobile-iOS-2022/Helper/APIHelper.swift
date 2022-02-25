//
//  APIHelper.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 17/02/2022.
//

import Foundation


enum HttpRequestError : Error, CustomStringConvertible{
    case fileNotFound(String)
    case badURL(String)
    case failingURL(URLError)
    case requestFailed
    case outputFailed
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknown
    
    var description : String {
        switch self {
        case .badURL(let url): return "Bad URL : \(url)"
        case .failingURL(let error): return "URL error : \(error.failureURLString ?? "")\n \(error.localizedDescription)"
        case .requestFailed: return "Request Failed"
        case .outputFailed: return "Output data Failed"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case .JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknown: return "unknown error"
        case .fileNotFound(let filename): return "File \(filename) not found"
        }
    }
}

class ApiHelper: Decodable {
    var API_URL: String
    var API_PORT: Int
    
    private enum CodingKeys: String, CodingKey {
        case API_URL = "apiUrl"
        case API_PORT = "apiPort"
       
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        API_URL = try values.decode(String.self, forKey: .API_URL)
        API_PORT = try values.decode(Int.self, forKey: .API_PORT)
    }

    func getURL() -> URL {
        return getURL(appended: "")
    }
    
    func getURL(appended: String) -> URL {
        return URL(string: API_URL + appended)!
    }
    
}

enum ApiServiceError {
    case ACCESS_DENIED(String)
    case NOT_FOUND(String)
    case INTERNAL_ERROR(String)
    case UNKNOWN(String)
}

extension CharacterSet {
    static var urlQueryValueAllowed: CharacterSet {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}



class ApiService {
    static var config: ApiHelper!
    
    static func post<T: Decodable>(_ t: T.Type, route: String, parameters: [String: Any], onsuccess: @escaping (T) -> Void){
        return post(t, route: route, parameters: parameters, onsuccess: onsuccess, onerror: { (response, error) in
            print("Ignored error : \(String(describing: error)) for response \(response)")
        })
    }
    
    static func get<T: Decodable>(_ t: T.Type, route: String, onsuccess: @escaping (T) -> Void){
        return get(t, route: route, onsuccess: onsuccess, onerror: { (response, error) in
            print("Ignored error : \(String(describing: error)) for response \(response)")
        })
    }

    static func post<T: Decodable>(_ t: T.Type, route: String, parameters: [String: Any], onsuccess: @escaping (T) -> Void, onerror: @escaping (HTTPURLResponse, Error?) -> Void){
        var request = URLRequest(url: config.getURL(appended: route))
        request.httpBody = parameters.percentEncoded()
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                onerror(response as! HTTPURLResponse, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                onerror(response as! HTTPURLResponse, nil)
                return
            }
            
            if let data = data, let o = try? JSONDecoder().decode(T.self, from: data){
                onsuccess(o)
            }
        })
        
        task.resume()
    }
    
    static func get<T: Decodable>(_ t: T.Type, route: String, onsuccess: @escaping (T) -> Void, onerror: @escaping (HTTPURLResponse, Error?) -> Void){
        var request = URLRequest(url: config.getURL(appended: route))
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                onerror(response as! HTTPURLResponse, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                onerror(response as! HTTPURLResponse, nil)
                return
            }
            
            if let data = data, let o = try? JSONDecoder().decode(T.self, from: data){
                onsuccess(o)
            }
        })
        
        task.resume()
    }
}
