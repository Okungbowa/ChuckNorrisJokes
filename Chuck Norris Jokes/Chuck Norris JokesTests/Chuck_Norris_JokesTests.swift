//
//  Chuck_Norris_JokesTests.swift
//  Chuck Norris JokesTests
//
//  Created by Joshua Okungbowa on 09/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import XCTest
@testable import Chuck_Norris_Jokes

class Chuck_Norris_JokesTests: XCTestCase {


    func testGetJoke() {
        let session = URLSession.shared
        
        RequestJoke(session: session).getJoke() { (result, success) in
            XCTAssert(result.uppercased().contains("CHUCK") && success == true)
            //Test should pass a Chuck Norris Joke is passed out of the class with the 'Success' Bool set to true            
        }
    }
    
    func testGetMultipleJokes () {
        let session = URLSession.shared
        var chuckCount = 0
        
        RequestJoke(session: session).getMultipleJokes() { (resultArr, success) in
            for result in resultArr {
                if result.uppercased().contains("CHUCK") {
                    chuckCount += 1
                }
                
                }
            XCTAssert(chuckCount == 10 && success == true)
            //Test should pass if 10 Chuck Norris Jokes are passed out of the class with the 'Success' Bool set to true

        }
    }
    
}
