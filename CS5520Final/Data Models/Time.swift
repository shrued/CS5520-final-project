//
//  Time.swift
//  CS5520Final
//
//  Created by 陈语佳 on 12/7/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Time: Codable {
    @DocumentID var id: String?
    var time: Int
    
    init(time: Int) {
        self.time = time
    }
}
