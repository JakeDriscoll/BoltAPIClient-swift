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
    private let localsession = URLSession(configuration: .default)
    private weak var currentOperation: URLSessionTaskOperation?
    // ALL requests to the Bolt P2Pe are POST requests

    //private let privateKey: String
    private let privateKey = ""
    
    //public init(apiClient: APIClient, apiKey: String){
    public init() {
        self.apiClient = APIClient()
        //self.privateKey = apiKey
    }
    
    /// Sends a request to Marvel servers, calling the completion method when finished
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        //let endpoint = self.endpoint(for: request)

        guard let endpoint = URL(string: self.baseEndpointUrl.absoluteString + request.resourceName) else { return }
        do {
            let encoder = JSONEncoder()
            //let decoder = JSONDecoder()
            
            //let request = ListTerminal(merchantID: "800000000120")
            let jsonData = try encoder.encode(request)

            let string = String(data: jsonData, encoding: .utf8)!
            print(string)
            let session = URLSession.shared

            
            var urlRequest = URLRequest(url: endpoint)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Authorization": self.privateKey,
                "Accept": "application/json"
            ]

            //let task2 = self.apiClient.request(<#T##request: URLRequest##URLRequest#>, completion: <#T##(Data?, URLResponse?, Error?) -> ()#>)
            let task = session.uploadTask(with: urlRequest, from: jsonData) { (data,response,error)  in

                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    print(httpResponse.allHeaderFields)
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8){
                    print(dataString)
                } else if let error = error {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
                    


            }
            task.resume()
//            let task = session.uploadTask(with: urlRequest, from: jsonData) { data, response, error in
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print(dataString)
//                }
//
//            }
//
//            task.resume()
        } catch{
            print("Something went wrong")
            
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
