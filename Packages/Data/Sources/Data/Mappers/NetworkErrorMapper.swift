//
//  File.swift
//  Data
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import Networking
import Domain

public enum NetworkErrorMapper {
    public static func map(_ error: NetworkError) -> RepositoryError {
        switch error {
        case .invalidURL:
            return .custom("error_invalid_url")
        case .invalidResponse:
            return .custom("error_invalid_response")
        case .statusCode(let code):
            if code == 404 {
                return .custom("error_no_results")
            } else {
                return .custom("error_server_generic")
            }
        case .underlying:
            return .custom("error_network_generic")
        }
    }
}
