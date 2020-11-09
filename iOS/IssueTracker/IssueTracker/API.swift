//
//  API.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import Foundation
import Alamofire

class API {
    static let shared: API = API()
    
    func get<T: Codable>(with query: String = "", from endpoint: EndPoint, completion : @escaping (Result<[T], Error>) -> Void) {
        AF.request(endpoint.path + query, method: .get)
            .validate()
            .responseDecodable(of: [T].self) { (response) in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func post<T: Codable>(data: T, to endpoint: EndPoint, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request(endpoint.path, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: Response.self) { (response) in
                switch response.result {
                case .success(let result):
                    completion(.success(result.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func put<T: Codable>(data: T, to endpoint: EndPoint, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request(endpoint.path, method: .put, parameters: data)
            .validate()
            .responseDecodable(of: Response.self) { (response) in
                switch response.result {
                case .success(let result):
                    completion(.success(result.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func delete(at id: Int, from endpoint: EndPoint, completion : @escaping (Result<String, Error>) -> Void) {
        let parameters: [String: Int] = [
            "id": id
        ]
        AF.request(endpoint.path, method: .delete, parameters: parameters)
            .validate()
            .responseDecodable(of: Response.self) { (response) in
                switch response.result {
                case .success(let result):
                    completion(.success(result.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
