//
//  RecordingInfo.swift
//  CS5520Final
//
//  Created by Hanru Chen on 12/2/23.
//

import Foundation
import FirebaseFirestoreSwift

struct RecordingInfo: Codable {
    @DocumentID var id: String?
    var foodName: String
    var caloriesAmount: String
    var sugarAmount: String
    var sodiumAmount: String
    var waterAmount: String
    
    init(foodName: String, caloriesAmount: String, sugarAmount: String, sodiumAmount: String, waterAmount: String) {
        self.foodName = foodName
        self.caloriesAmount = caloriesAmount
        self.sugarAmount = sugarAmount
        self.sodiumAmount = sodiumAmount
        self.waterAmount = waterAmount
    }
}
