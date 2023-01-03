//
//  ApiManager.swift
//  WeatherTestApp
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
    
    func request(serviceURL: String, httpMethod: HttpMethod = .get) async throws -> (Data, URLResponse) {
        let request = getRequest(serviceURL: serviceURL, httpMethod: httpMethod)
        return try await makeApiCall(request: request)
    }
    
    private func makeApiCall(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let sessionTask = self.session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        guard let data1 = data, let response1 = response else {
                            fatalError("Expected non-nil result 'data1' in the non-error case")
                        }
                        continuation.resume(returning: (data1, response1))
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    private func getFullEndpointUrl(serviceUrl: String) -> String {
        return (APIEndPoints.API_BASE_URL + serviceUrl).urlEncoded
    }
    
}
