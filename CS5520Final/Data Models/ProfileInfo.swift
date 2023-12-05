//
//  ProfileInfo.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/4/23.
//

import UIKit
import Foundation
import FirebaseFirestoreSwift

struct ProfileInfo: Codable {
    @DocumentID var id: String?
    var name: String
    var age: Int
    var gender: String
    var weight: Double
    var height: String
    var goal: Double
    
    init(name: String, age: Int, gender: String, weight: Double, height: String, goal: Double) {
        self.name = name
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.goal = goal
    }
}
