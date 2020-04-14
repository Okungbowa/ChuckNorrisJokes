//
//  GetJoke.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 12/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import Foundation

class RequestJoke {
    
    private let session : URLSession
    let errorMessage = "Chuck Norris jokes are so funny, they can break the server"
    var url:URL?
    
    //Initialiser included to pass in a MockURLSession Class for testing the API in the Unit test, but as application does not write against the production database, and just reads information, it was deemed acceptable to use the production server to test as these are more realistic conditions.
    init(session : URLSession) {
        self.session = session
    }
    
    //Datatask which handles the response from the server
    func getJoke ( completionHandler: @escaping (_ Result: String, _ Success: Bool) -> Void) {
        url = URL(string: "http://api.icndb.com/jokes/random?exclude=[explicit]")
        
        //Create session to pull data from endpoint
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                //If error has data, the error is captured and passed out the closure, and the Success Bool is set to false
                completionHandler(error!.localizedDescription, false)
                
            } else if data != nil {
                do {
                    //Down cast the JSON data as Dictionary type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>

                    //Async
                    DispatchQueue.main.async {
                        if (json["type"] as! String) == "success" {
                            if let value = json["value"] as? Dictionary<String,Any> {
                                if let joke = value["joke"] as? String {
                                    //If a result has been successful, the HTML entities are removed and passed out the closure, the Success Bool is set to true
                                    completionHandler(joke.replacingOccurrences(of: "&quot;", with: "\"").replacingOccurrences(of: "&amp;", with: "&"), true)
                                }
                            }
                        } else {
                            //If the server does not return succes, the custom error messaged is passed through the result, and the bool set to false
                            completionHandler(self.errorMessage, false)
                        }
                        
                    }
                    
                } catch {
                    //If JSON serialiaziton fails, the custom error messaged is passed through the result, and the bool set to false
                    completionHandler(self.errorMessage, false)
                }
            }
        }
        task.resume()
    }
    
    
    
    func getMultipleJokes ( completionHandler: @escaping (_ Result: [String], _ Success: Bool) -> Void) {
        url = URL(string: "http://api.icndb.com/jokes/random/10?exclude=[explicit]")
        
        //Initialise Blank Array, when initialising the result arr, there would othen be an empty string, so the 'removeAll' method is used to make sure the Arr count is zero.
        var result = [String()]
        result.removeAll()
        
        //Create session to pull data from endpoint
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                //If error has data, the error is captured, appended to the string array and passed out the closure, and the Success Bool is set to false
                result.append(self.errorMessage)
                completionHandler(result, false)
                
            } else if data != nil {
                do {
                    //Down cast the JSON data as Dictionary type
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                    
                    //Async
                    DispatchQueue.global().async {
                        //Put in one second sleep across processes as the database server retieved data to quickly to see the loading messages, included for purpose of this project.
                        sleep(1)
                        
                        DispatchQueue.main.async {
                            if (json["type"] as! String) == "success" {
                                if let value = json["value"] as? [Any] {
                                    
                                    for item in value {
                                        let joke = (item as! Dictionary<String,Any>)["joke"] as! String
                                        result.append(joke.replacingOccurrences(of: "&quot;", with: "\"").replacingOccurrences(of: "&amp;", with: "&"))
                                    }
                                    
                                    //If a result has been successful, the HTML entities are removed from each joke and passed out the closure, the Success Bool is set to true
                                    completionHandler(result,true)
                                    
                                }
                            } else {
                                //If the server does not return succes, the custom error messaged is passed through the result, and the bool set to false
                                result.append(self.errorMessage)
                                completionHandler(result, false)
                            }
                            
                        }
                    }
                } catch {
                    //If JSON serialiaziton fails, the custom error messaged is passed through the result, and the bool set to false
                    result.append(self.errorMessage)
                    completionHandler(result, false)
                }
            }
        }
        task.resume()
    }
    
}
