//
//  ToDoItem.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 08.01.2021.
//

import Foundation

public class ToDoItem: Codable{
    let id: Int?
    var title: String?
    var subtitle: String?
    var deadLine: String?
    var status: Bool?
    
    init(id: Int, title: String, subtitle: String, deadLine: String, status: Bool) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.deadLine = deadLine
        self.status = status
    }
}
