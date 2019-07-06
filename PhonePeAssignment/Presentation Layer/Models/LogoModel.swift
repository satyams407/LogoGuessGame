//
//  LogoModel.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

// MARK: - LogoModel
struct LogoModel: Codable {
    let imgURL: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case imgURL = "imgUrl"
        case name
    }
    
    init?(with json: [String: Any]) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else { return nil }
        
        guard let model = try? JSONDecoder().decode(LogoModel.self, from: data) else {
            return nil
        }
        self = model
    }
}


