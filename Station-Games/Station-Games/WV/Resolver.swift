//
//  Resolver.swift
//  Station-Games
//
//  Created by Dias Atudinov on 02.12.2024.
//

import Foundation

class Resolver: NSObject, URLSessionTaskDelegate {
    func resolveIt(from originalURL: URL, completion: @escaping (URL?) -> Void) {
        var request = URLRequest(url: originalURL)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148", forHTTPHeaderField: "User-Agent")

        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, let finalURL = httpResponse.url {
                completion(finalURL)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
       
        completionHandler(request)
    }
    
    
    static func checking() async -> Bool {
        let urlString = Links.winStarData
        
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedString) {
            
            let handler = Resolver()
            
            return await withCheckedContinuation { continuation in
                handler.resolveIt(from: url) { finalURL in
                    print(finalURL)
                    if let finalURL {
                        if Links.shared.finalURL == nil && ((finalURL.host?.contains("google")) != true) {
                            Links.shared.finalURL = finalURL
                        }
                        
                        continuation.resume(returning: finalURL.host?.contains("google") ?? true)
                    } else {
                        Links.shared.finalURL = finalURL
                        continuation.resume(returning: false)
                    }
                    
                }
            }
            
        } else {
            return false
        }
    }
    
}
