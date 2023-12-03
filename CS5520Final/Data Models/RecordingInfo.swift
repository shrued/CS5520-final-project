import Foundation
import FirebaseFirestoreSwift

struct RecordingInfo: Codable {
    @DocumentID var id: String?
    var foodName: String
    var date: Date
    var caloriesAmount: Double
    var sugarAmount: Double
    var sodiumAmount: Double
    var waterAmount: Double
    
    init(foodName: String, date: Date = Date(), caloriesAmount: Double, sugarAmount: Double, sodiumAmount: Double, waterAmount: Double) {
        self.foodName = foodName
        self.caloriesAmount = caloriesAmount
        self.sugarAmount = sugarAmount
        self.sodiumAmount = sodiumAmount
        self.waterAmount = waterAmount
        self.date = date
    }
}

