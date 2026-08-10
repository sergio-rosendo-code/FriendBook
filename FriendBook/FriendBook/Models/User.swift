//
//  User.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/7/26.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    var id: UUID
    var registered: Date
    var name: String
    var company: String
    var email: String
    var address: String
    var about: String
    @Relationship(deleteRule: .cascade, inverse: \Friend.owner)
    var friends: [Friend]
    
    init(id: UUID, registered: Date, name: String, company: String, email: String, address: String, about: String, friends: [Friend]) {
        self.id = id
        self.registered = registered
        self.name = name
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.friends = friends
    }
    
    enum CodingKeys: CodingKey {
        case id
        case registered
        case name
        case company
        case email
        case address
        case about
        case friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.name = try container.decode(String.self, forKey: .name)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.friends, forKey: .friends)
    }
}
