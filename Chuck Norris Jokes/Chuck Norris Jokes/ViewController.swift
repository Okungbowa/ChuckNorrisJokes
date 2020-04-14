//
//  ViewController.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 09/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Function behind 'Get Random Joke' Button
    @IBAction func getRandomJokePressed(_ sender: Any) {
        performSegue(withIdentifier: "toRandomJokeVC", sender: nil)
    }
    
    //Function behind 'Get list of Jokes' Button
    @IBAction func getJokeListPressed(_ sender: Any) {
        performSegue(withIdentifier: "toJokeListVC", sender: nil)
    }
    

}

