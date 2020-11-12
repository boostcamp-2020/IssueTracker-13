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
    
    let userToken = UserToken()
    
    lazy var headers: HTTPHeaders = [
        "Authorization": "Bearer \(userToken.token)",
        "Accept": "application/json"
    ]
    
    func get<T: Codable>(with query: String = "", from endpoint: EndPoint, completion : @escaping (Result<[T], Error>) -> Void) {
        guard let encoded = (endpoint.path + query).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        AF.request(url, method: .get, headers: headers)
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
    
    func post<T: Codable, U: Codable>(data: T, to endpoint: EndPoint, completion : @escaping (Result<U, Error>) -> Void) {
        AF.request(endpoint.path, method: .post, parameters: data, headers: headers)
            .validate()
            .responseDecodable(of: U.self) { (response) in
                switch response.result {
                case .success(let result):
                    print(result)
                    completion(.success(result))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func put<T: Codable>(at id: String = "", data: T, to endpoint: EndPoint, completion : @escaping (Result<String, Error>) -> Void) {
        guard let encoded = (endpoint.path + (id.isEmpty ? "" : "/\(id)")).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        AF.request(url, method: .put, parameters: data, headers: headers)
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
    
    func put<T>(at id: String = "", data: T, to endpoint: EndPoint, completion : @escaping (Result<String, Error>) -> Void) {
        guard let encoded = (endpoint.path + (id.isEmpty ? "" : "/\(id)")).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: encoded) else { return }
        AF.request(url, method: .put, parameters: data as? Parameters, encoding: JSONEncoding.default, headers: headers)
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
        AF.request(endpoint.path, method: .delete, parameters: parameters, headers: headers)
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
