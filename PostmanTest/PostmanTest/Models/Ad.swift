//
//  Ad.swift
//  PostmanTest
//
//  Created by Gevorg Hovhannisyan on 23.11.21.
//

import Foundation

// MARK: - Ad
class Ad: Codable {
    
    let id, state: Int
    let name: String?
    let userID, categoryID: Int
    let adDescription: String?
    let image: String?
    let owner: Int
    let isBestPrice: Bool?
    
}
