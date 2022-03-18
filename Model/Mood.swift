//
//  Mood.swift
//  Recorday
//
//  Created by HyeJee Kim on 2022/03/04.
//

import UIKit

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
