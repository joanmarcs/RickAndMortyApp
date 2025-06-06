//
//  File.swift
//  Networking
//
//  Created by Joan Marc Sanahuja on 6/6/25.
//

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case underlying(Error)
}

