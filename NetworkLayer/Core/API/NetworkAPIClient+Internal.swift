//
//  NetworkAPIClient+Internal.swift
//
//  Created by Sachin on 13/04/17.
//


import Foundation
import ObjectMapper
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

extension NetworkAPIClient {
    
    class func encode(parameters : [NSObject : AnyObject]) -> [NSObject : AnyObject] {
        var result = [NSObject : AnyObject]()
        for (key, value) in parameters {
            var parameter : String!
            if let stringValue = value as? String {
                parameter = stringValue
            } else if let numberValue = value as? NSNumber {
                parameter = numberValue.stringValue
            } else {
                parameter = value.description
            }
            result[key] = parameter.removingPercentEncoding as AnyObject?
        }
        return result
    }
    
    class func queryItems(parameters : [String : String]) -> [NSURLQueryItem] {
        var queryItems = [NSURLQueryItem]()
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        
        return queryItems
    }
    
    class func parameterEncodedString(parameters : [String : String]) -> String {
        var encodedParameters = ""
        for (key, value) in parameters {
            if !encodedParameters.isEmpty {
                encodedParameters += "&"
            }
            encodedParameters += "\(key)=\(value)"
        }
        return encodedParameters
    }
    
    
    func urlRequest(route : AppJSONAPIRouter, cachePolicy : NSURLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = NetworkAPIClient.TimeoutForRequest) -> URLRequest {
        
        let path = route.path
        var urlComponents = URLComponents(string: self.settingsProvider.server)
        urlComponents?.path = path
        let configuredParameters = self.configure(parameters: route.parameters)
        urlComponents?.queryItems = NetworkAPIClient.queryItems(parameters: configuredParameters) as [URLQueryItem]?
        var urlRequest = URLRequest(url: (urlComponents?.url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        urlRequest.httpMethod = route.method.rawValue
        for (key, value) in route.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        urlRequest.httpBody = route.body
        return urlRequest
    }
    
    func configure(parameters : [String : String]?) -> [String : String] {
        var configuredParameters = Dictionary<String, String>()
        if let parameters = parameters {
            configuredParameters = parameters
        }
        return configuredParameters
    }
    
    func request(request: URLRequestConvertible, completion: @escaping NetworkResultCompletion) -> NetworkRequest? {
        let theRequest = self.manager.request(request).validate().responseJSON { response in
            var inError : Error?
            if var theError = response.error {
                theError = self.handleError(error: theError as NSError, httpURLReponse: response.response, data:  response.data as NSData?)
                inError = theError
            }
            completion(response.value as AnyObject? ,inError as NSError?)
        }
        return theRequest
    }
    
    func requestModel<T : Mappable>(request : URLRequestConvertible, keyPath: String? = nil, completion : ((_ result : T?, _ error : NSError?) -> Void)?) -> NetworkRequest? {
        let theRequest = self.manager.request(request).responseObject(keyPath: keyPath) { (response: DataResponse<T>) in
            
            switch response.result {
            case .success(_):
                completion?(response.value, nil)
                
            case .failure(let error):
                let error = self.handleError(error: error as NSError , httpURLReponse: response.response, data: response.data as NSData?)
                completion?(nil, error)
            }
        }
        return theRequest
    }
    
    func requestArray<T : Mappable>(request : URLRequestConvertible, keyPath: String? = nil, completion : ((_ result : [T]?, _ error : NSError?) -> Void)?) -> NetworkRequest? {
        
        let theRequest = self.manager.request(request).responseArray(keyPath: keyPath) { (response: DataResponse<[T]>) in
            
            switch response.result {
            case .success(_):
                completion?(response.value, nil)

            case .failure(let error):
                let error = self.handleError(error: error as NSError , httpURLReponse: response.response, data: response.data as NSData?)
                completion?(nil, error)
            }
        }
        return theRequest
    }
    
    private func handleError(error : NSError, httpURLReponse : HTTPURLResponse?, data: NSData?) -> NSError {
        var inError = error
        guard error.code != NSURLErrorCancelled else {
            // this is when we cancel the operation from autocomplete
            return error
        }
        
        let errorCodes = (error.code, httpURLReponse?.statusCode ?? HTTPErrorCode.UnknownError.rawValue) // TODO: Do not force unbox
        
        var NetworkErrorMessage: String? = nil
        if let errorData = data, let msg = NSString(data: errorData as Data, encoding: String.Encoding.utf8.rawValue) , msg.length > 0 {
            NetworkErrorMessage = msg as String
            if let message = NetworkErrorMessage {
                inError = NSError(domain: "NetworkError", code: errorCodes.1, userInfo: [NSLocalizedDescriptionKey: message])
            }
        }
        return inError
    }
    
}
