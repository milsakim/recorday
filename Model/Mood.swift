//
//  Mood.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

/*
enum Mood: Int, CaseIterable {
    
    static let angryEmoji: String = "mood-angry"
    static let badEmoji: String = "mood-bad"
    static let expressionlessEmoji: String = "mood-expressionless"
    static let goodEmoji: String = "mood-good"
    static let happyEmoji: String = "mood-happy"
    
    case angry = 0
    case bad = 100
    case expressionless = 200
    case good = 300
    case happy = 400
    
}
*/

struct Mood {
    
    static var moods: [Mood] = {
        var moods = [
            Mood(id: "0", title: "happy", emoji: "😄", color: UIColor("#FFDDD3")),
            Mood(id: "100", title: "good", emoji: "🙂", color: UIColor("#F3BFB3")),
            Mood(id: "200", title: "so so", emoji: "😐", color: UIColor("#CBE1EF")),
            Mood(id: "300", title: "bad", emoji: "🙁", color: UIColor("#9ACDE0")),
            Mood(id: "400", title: "angry", emoji: "😠", color: UIColor("#5EA9BE"))
        ]
        
        return moods
    }()
    
    let id: String
    let title: String
    let emoji: String
    let color: UIColor?
    
}
