//
//  FilterWorker.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import Foundation

class FilterWorker {
    
    func fetchAuthors(handler: @escaping ([User]) -> Void) {
        let users = [User(name: "강병민1", img: "temp1.jpg"),
                     User(name: "박동현1", img: "temp2.jpg"),
                     User(name: "박인서1", img: "temp3.jpg"),
                     User(name: "신준수1", img: "temp4.jpg"),
                     User(name: "전쟁열1", img: "temp5.jpg")]
        handler(users)
    }
    
    func fetchAssignees(handler: @escaping ([User]) -> Void) {
        let users = [User(name: "강병민2", img: "temp1.jpg"),
                     User(name: "박동현2", img: "temp2.jpg"),
                     User(name: "박인서2", img: "temp3.jpg"),
                     User(name: "신준수2", img: "temp4.jpg"),
                     User(name: "전쟁열2", img: "temp5.jpg")]
        handler(users)
    }
    
    func fetchMilestones(handler: @escaping ([String]) -> Void) {
        let milestones = ["마일스톤1",
                          "마일스톤2",
                          "마일스톤3",
                          "마일스톤4",
                          "마일스톤5"]
        handler(milestones)
    }
    
    func fetchLables(handler: @escaping ([Label]) -> Void) {
        let labels = [Label(id: 1, title: "라벨1", description: "라벨1입니다", color: "", backgroundColor: ""),
                      Label(id: 2, title: "라벨2", description: "라벨2입니다", color: "", backgroundColor: ""),
                      Label(id: 3, title: "라벨3", description: "라벨3입니다", color: "", backgroundColor: "")]
        handler(labels)
    }

}
