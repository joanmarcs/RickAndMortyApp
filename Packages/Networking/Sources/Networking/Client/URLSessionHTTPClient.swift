//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 3/6/25.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let config: NetworkConfig
    private let session: URLSession
    
    public init(config: NetworkConfig, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }
    
    public func request(endpoint: Endpoint, method: HTTPMethod, body: Data?) async throws -> Data {
        guard var components = URLComponents(url: config.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.cachePolicy = config.cachePolicy
        request.timeoutInterval = config.timeout
        
        #if DEBUG
        print("[HTTP Request] \(method.rawValue) \(url.absoluteString)")
        if let queryItems = components.queryItems {
            print("Query Items: \(queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&"))")
        }
        #endif
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            #if DEBUG
           print("[HTTP Response] \(httpResponse.statusCode) from \(url.absoluteString)")
           if let responseBody = String(data: data, encoding: .utf8) {
               print("Response Body:\n\(responseBody)\n")
           }
           #endif
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.statusCode(httpResponse.statusCode)
            }
            
            return data
        } catch let error as NetworkError {
            #if DEBUG
            print("[HTTP Error] \(error)")
            #endif
            throw error
        } catch {
            #if DEBUG
            print("[HTTP Error] \(error.localizedDescription)")
            #endif
            throw NetworkError.underlying(error)
        }
    }
}

