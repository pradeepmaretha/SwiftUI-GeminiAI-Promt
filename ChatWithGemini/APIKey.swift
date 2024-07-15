//
//  APIKey.swift
//  ChatWithGemini
//
//  Created by Pradeep MACMINI on 15/07/24.
//

import Foundation

enum APIKey {
    
    static var `default`:String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("couldn't find file 'GenerativeAI-Info.plist'")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else{
            fatalError("couldn't fine API_KEY")
        }
        if value .starts(with: "_"){
            fatalError("Follow the instruction at   ai.google.dev.tutorials/setup")
        }
        return value
    }
    
}
