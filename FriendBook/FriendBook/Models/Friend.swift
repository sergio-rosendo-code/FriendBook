//
//  Friend.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/9/26.
//

import SwiftData
import SwiftUI

@Model
class Friend: Codable {
    var id: UUID
    var name: String
    var owner: User?
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
