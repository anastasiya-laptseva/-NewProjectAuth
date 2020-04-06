//
//  NetworkManager.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 3/24/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    var peoples: Peoples?
    
    func fetchData() {
        // request link
        let request = AF.request("https://swapi.co/api/people")
        // parce json with structure
        request.responseDecodable(of: Peoples.self) { (response) in
            guard let p = response.value else { return }
            self.peoples = p
        }
    }
    
    func getPeople(index: Int) -> String {
        guard let p = peoples else {
            return ""
        }
        
        if index<p.count{
            return p.all[index].name
        }
        
        return ""
    }
}

struct People: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
      case name
    }
}

struct Peoples: Decodable {
    let count: Int
    let all: [People]
  
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}




//    func fetchData() {
//        let session = URLSession.shared
//        let url = URL(string:  "https://swapi.co/api/people/?format=json")
//        guard url != nil else {
//            return
//        }
////        var components = URLComponents()
////        components.scheme = url?.scheme
////        components.host = url?.host
////        components.path = url!.path
////        components.queryItems = [
////
////            URLQueryItem(name: "page", value: String(1))
////        ]
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
////        request.httpBody
//        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
////            DispatchQueue.main.async {
////                <#code#>
////            }
//            guard let data = data else { return }
//            guard error != nil else { return }
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode)
//            else { return }
//
//            self?.parse(data: data)
//        }
//        task.resume()
//    }
//
//    func parse (data: Data)  {
//        do {
//            //                let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //                print(json)
//            let json = try JSONDecoder().decode(StarWarsPeople.self, from: data)
//            json.people.forEach {
//                print($0.name)
//            }
//        } catch {
//            print(error)
//        }
//    }
//struct StarWarsPeople: Codable {
//    let count: Int
//    let next: String
//    let people: [SWChar]
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case next
//        case people = "results"
//    }
//}
//struct SWChar: Codable {
//    let name: String
//}
