//
//  BoltAPIClient.swift
//  TestingProject
//
//  Created by Jakob Driscoll on 8/22/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation
public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

class BoltAPIClient {
    private let baseEndpointUrl = URL(string: "https://bolt-uat.cardpointe.com:6443/api/v3/")!
    private let apiClient: APIClient
    private weak var currentOperation: URLSessionTaskOperation?
    // ALL requests to the Bolt P2Pe are POST requests
    private let privateKey = ""
    
    //public init(apiKey: String){
    //public init(url: URL, apiKey: String){
    public init() {
        self.apiClient = APIClient()
        //self.privateKey = apiKey
    }
    
    func OpenTerminalSession(merchantId: String, terminalID: String, completion: @escaping ResultCallback<String?>) {
        let request = ConnectToTerminal(merchantId: merchantId, terminalID: terminalID)
        guard let urlRequest = buildURLRequest(resourceName: request.resourceName) else { return }
        do {
            let jsonData = try JSONEncoder().encode(request)
            let task = URLSession.shared.uploadTask(with: urlRequest, from: jsonData) { (data,response,error)  in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    print(httpResponse.allHeaderFields)
                }
                if let httpResponse = response as? HTTPURLResponse, let sessionKeyHeader = httpResponse.allHeaderFields["X-CardConnect-SessionKey"] as? String {
                    if let sessionKey = sessionKeyHeader.split(separator: ";").first {
                        completion(.success(String(sessionKey)))
                        print(String(sessionKey))
                        //strongSelf.headers["X-CardConnect-SessionKey"] = String(sessionKey)
                    }
                    
                }
                if let error = error {
                    
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            print(error.localizedDescription)
            return
        }

    }
    
    private func buildURLRequest(resourceName: String, sessionID: String? = nil) -> URLRequest? {
        guard let endpoint = URL(string: self.baseEndpointUrl.absoluteString + resourceName) else { return nil }
        // All Bolt P2Pe requests are POST
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": self.privateKey,
            "Accept": "application/json"
        ]
        if let sessionID = sessionID {
            urlRequest.addValue(sessionID, forHTTPHeaderField: "X-CardConnect-SessionKey")
        }

        return urlRequest
    }
    /// Sends Request to the Bolt P2Pe
    
    public func send<T: APIRequest>(_ request: T, sessionID: String? = nil, completion: @escaping ResultCallback<T.Response>) {

        guard var urlRequest = buildURLRequest(resourceName: request.resourceName, sessionID: sessionID) else { return  }
        do {
            let session = URLSession.shared
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
//            let testString = String(data: jsonData, encoding: .utf8)!
//            print(testString)
            let task = session.dataTask(with: urlRequest) { (data,response,error)  in
            //let task = session.uploadTask(with: urlRequest, from: jsonData) { (data,response,error)  in

                if let httpResponse = response as? HTTPURLResponse {
                    print("Response Code: ")
                    print(httpResponse.statusCode)
                    //print(httpResponse.allHeaderFields)
                }

                if let data = data, let dataString = String(data: data, encoding: .utf8){
                    do{
                        let boltResponse = try JSONDecoder().decode(T.Response.self, from: data)
                        
                        completion(.success(boltResponse))
                    }
                    catch {
                        print("Problem decoding")
                        print(dataString)
                        completion(.failure(error))
                    }
                } else if let error = error {
                    
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                    


            }
            task.resume()
        } catch{
            print(error.localizedDescription)
            print("Error in ")
            
        }
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try jsonEncoder.encode(request)
//        let json = String(data: jsonData, encoding: String.Encoding.utf16)
//        var postRequest = URLRequest(url: URL(fileURLWithPath: endpoint))
//
//            postRequest.httpMethod = "POST"
//            postRequest.httpBody = jsonData
//            print(json)
//            let task = URLSession.shared.dataTask(with: postRequest) { data, response, error in
//                guard let data = data else {
//                    return
//                }
//                do {
//                    let boltResponse = try JSONDecoder().decode(APIResponse<T.Response>.self, from: data)
//                    print(boltResponse)
//                }
//                catch{
//                    print("Something broken")
//                }
//            }
//        } catch {
//            print("Something went wrong")
//        }
        

        
//        self.currentOperation = apiClient.request(URLRequest(url: URL(fileURLWithPath: endpoint)), priority: .veryHigh) { (data, response, error) in
//            guard let data = data else {
//                return
//            }
//            do
//            {
//                let boltResponse = try JSONDecoder().decode(APIResponse<T.Response>.self, from: data)
//                print(boltResponse)
//            }
//            catch {
//                completion(.failure(error))
//            }
//        }
    }
    
    /// Encodes a URL based on the given request
    /// Everything needed for a public request to Marvel servers is encoded directly in this URL
//    private func endpoint<T: APIRequest>(for request: T) -> URL {
//
//
//        let retURL = URL(fileURLWithPath: <#T##String#>)
//        print(fullURL)
//        print("Testing")
//        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
//            fatalError("Bad resourceName: \(request.resourceName)")
//        }
//        return baseUrl
//    }
    
    
}
