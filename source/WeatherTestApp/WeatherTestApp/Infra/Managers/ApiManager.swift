//
//  ApiManager.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 02/01/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class ApiManager: NSObject, URLSessionTaskDelegate {
    
    static let shared: ApiManager = ApiManager()
    
    override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    private var session: URLSession!
    
    private func getRequest(serviceURL: String, httpMethod: HttpMethod = .get) -> URLRequest {
        var requestURL: String = ""
        if !serviceURL.contains("http") {
            requestURL = getFullEndpointUrl(serviceUrl: serviceURL)
        } else {
            requestURL = serviceURL.urlEncoded
        }
        var request = URLRequest(url: URL(string: "\(requestURL)")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func request(serviceURL: String, httpMethod: HttpMethod = .get, completion: @escaping (Data?, Error?) -> Void) {
        let request = getRequest(serviceURL: serviceURL, httpMethod: httpMethod)
        makeApiCall(request: request, completion: completion)
    }
    
    private func makeApiCall(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        sessionTask.resume()
    }
    
    private func getFullEndpointUrl(serviceUrl: String) -> String {
        return (APIEndPoints.API_BASE_URL + serviceUrl).urlEncoded
    }
    
}
