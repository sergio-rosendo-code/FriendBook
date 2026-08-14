//
//  NavigationManager.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/12/26.
//

import SwiftUI

@Observable
class NavigationManager {
    var navigationPath = NavigationPath()
    
    public func push(route: Route) {
        navigationPath.append(route)
    }
}
