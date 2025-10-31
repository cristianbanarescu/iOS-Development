//
//  CombineiOSAppTests.swift
//  CombineiOSAppTests
//
//  Created by Cristian Banarescu on 31.10.2025.
//

import Testing
@testable import CombineiOSApp

struct CombineiOSAppTests {

    @Test func example() {
        let userService = UserService()
        
        userService.performFetchOfUsers()
    }

}
