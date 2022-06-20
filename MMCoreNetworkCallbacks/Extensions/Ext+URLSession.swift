//
//  Ext+URLSession.swift
//  
//
//  Created by Павел Кузин on 08/02/2022.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
public extension URLSession {
    
    func data(from request: URLRequest) async throws -> (Data,URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
    
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
         try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                 guard let data = data, let response = response else {
                     let error = error ?? URLError(.badServerResponse)
                     return continuation.resume(throwing: error)
                 }

                 continuation.resume(returning: (data, response))
             }

             task.resume()
        }
    }
}
