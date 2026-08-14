//
//  Route.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/12/26.
//

import Foundation

enum Route: Hashable {
    case profilePage(userId: UUID)
    case friendsPage(userId: UUID, userName: String)
}
