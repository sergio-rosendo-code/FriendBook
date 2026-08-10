//
//  FriendBookApp.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/7/26.
//

import SwiftData
import SwiftUI

@main
struct FriendBookApp: App {
    var body: some Scene {
        WindowGroup {
            FriendsPage()
        }
        .modelContainer(for: [User.self, Friend.self])
    }
}
