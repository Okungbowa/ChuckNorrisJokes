//
//  RandomJokeViewController.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 09/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import UIKit

class RandomJokeViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    //URL Session Immutables
    let url = URL(string: "http://api.icndb.com/jokes/random?exclude=[explicit]")
    let session = URLSession.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //RequestJoke Class called to get first initial batch of jokes after the view has been called
        RequestJoke(session: URLSession.shared).getJoke() { (result, success) in
            if success {
                self.jokeLabel.text = result
                print("joke: \(self.jokeLabel.text)")
            } else {
                self.presentAlert(title: "Error", message: result)
            }
        }
    }
    
    
    //Function behind 'Get Antoher' Button
    @IBAction func getAnotherButtonPressed(_ sender: Any) {
        RequestJoke(session: URLSession.shared).getJoke() { (result, success) in
            if success {
                self.jokeLabel.text = result
                print("joke: \(self.jokeLabel.text)")
            } else {
                self.presentAlert(title: "Error", message: result)
            }
        }
    }
    
    
    
    //Creates an alert object, and presents it with message
    func presentAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
