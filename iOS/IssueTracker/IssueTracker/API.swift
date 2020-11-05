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
        AF.request("http://27.96.130.188:3000/api/labels")
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
    
}
