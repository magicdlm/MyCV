//
//  Model.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

// MARK: - Resume
struct Resume: Decodable {
    let profile: Profile
    let summary: [String]
    let strength: Strength
    let experience: [Experience]
}

// MARK: - Experience
struct Experience: Decodable {
    let company: String
    let logo: URL?
    let startDate: Date
    let endDate: Date?
    let title: String
    let detail: String
    let keys: Set<String>
}

// MARK: - Profile
struct Profile: Decodable {
    let name, phone, email: String
}

// MARK: - Strength
struct Strength: Decodable {
    let knowledge, technical: [String]
}
