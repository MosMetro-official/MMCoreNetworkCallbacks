//
//  ViewController.swift
//  NetworkExample
//
//  Created by Гусейн on 20.06.2022.
//

import UIKit
import MMCoreNetworkCallbacks

struct Resp: Codable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
    
}

struct Comment: Codable, CustomStringConvertible {
    var description: String {
        return "\(postId) \(name) \(email) \(body)"
    }
    
    
    let postId: Int
    let name: String
    let email: String
    let body: String
    
    init(from: Data) async throws {
        let jsonDecoder = JSONDecoder()
        self = try jsonDecoder.decode(Self.self, from: from)
    }
    
    
    
}

struct CommentsResponse: Codable {
    
    let items: [Comment]
    
    init(from data: Data) async throws {
        let jsonDecoder = JSONDecoder()
        let items = try jsonDecoder.decode([Comment].self, from: data)
        self.items = items
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = APIClient(host: "jsonplaceholder.typicode.com")
        let activity = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        activity.startAnimating()
        self.view.addSubview(activity)
        activity.center = self.view.center
        Task {
            print("1")
            let resp = try await client.send(.GET(path: "/comments"))
            print("2")
            print("3")
            let comments = try await CommentsResponse(from: resp.data)
            print("4")
            print("5")
            activity.stopAnimating()
            print(comments.items)
        }
        
        
        
    }


}

