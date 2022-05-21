//
//  DailyRecordMetadata.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/04/28.
//

import Foundation

struct DailyRecordMetadata {
    
    // MARK: - Property
    
    var moodID: String
    var dateTimestamp: Double
    var timeTimestamp: Double
    var note: String = ""
    
    // MARK: - Initializer
    
    init(moodID: String, dateTimestamp: Double, timeTimestamp: Double) {
        self.moodID = moodID
        self.dateTimestamp = dateTimestamp
        self.timeTimestamp = timeTimestamp
    }
    
}
