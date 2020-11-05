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
    
    func getLabels(completion : @escaping (Result<[Label], Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/labels", method: .get)
            .validate()
            .responseDecodable(of: [Label].self) { (response) in
                switch response.result {
                case .success(let labels):
                    completion(.success(labels))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postLabel(_ postLabel: PostLabel, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/labels", method: .post, parameters: postLabel)
            .validate()
            .responseDecodable(of: ReponseMessage.self) { (response) in
                switch response.result {
                case .success(let message):
                    completion(.success(message.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func putLabel(_ putLabel: PutLabel, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/labels", method: .put, parameters: putLabel)
            .validate()
            .responseDecodable(of: ReponseMessage.self) { (response) in
                switch response.result {
                case .success(let message):
                    completion(.success(message.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getMilestones(completion : @escaping (Result<[Milestone], Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/milestones")
            .validate()
            .responseDecodable(of: [Milestone].self) { (response) in
                switch response.result {
                case .success(let milestones):
                    completion(.success(milestones))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postMilestone(_ postMilestone: PostMilestone, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/milestones", method: .post, parameters: postMilestone)
            .validate()
            .responseDecodable(of: ReponseMessage.self) { (response) in
                switch response.result {
                case .success(let message):
                    completion(.success(message.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func putMilestone(_ putMilestone: PutMilestone, completion : @escaping (Result<String, Error>) -> Void) {
        AF.request("http://27.96.130.188:3000/api/milestones", method: .put, parameters: putMilestone)
            .validate()
            .responseDecodable(of: ReponseMessage.self) { (response) in
                switch response.result {
                case .success(let message):
                    completion(.success(message.message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
