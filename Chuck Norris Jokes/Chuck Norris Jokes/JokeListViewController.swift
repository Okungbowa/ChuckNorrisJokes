//
//  JokeListViewController.swift
//  Chuck Norris Jokes
//
//  Created by Joshua Okungbowa on 11/04/2020.
//  Copyright © 2020 Joshua Okungbowa. All rights reserved.
//

import UIKit

class JokeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //JokeListViewController Objects
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLabel: UILabel!
    let url = URL(string: "http://api.icndb.com/jokes/random/10?exclude=[explicit]")
    var jokeArr : [String]?
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "LoadingCell")
        
        // Do any additional setup after loading the view.
        
        //RequestJoke Class called with 'getMultipleJokes' method which gets the first batch of jokes from the Chuck Norris Server.
        topLabel.isHidden = false
        RequestJoke(session: URLSession.shared).getMultipleJokes() { (resultArr, success) in
            if success {
                //Happy path
                self.jokeArr = resultArr
                self.topLabel.isHidden = true
                self.tableView.reloadData()
                
            } else {
                //Unhappy path
                self.topLabel.isHidden = true
                self.presentAlert(title: "Error", message: resultArr[0])
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            //Return the 10 Jokes
            return jokeArr?.count ?? 0
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ///Scroll View Objects
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        //Executes 'getMultipleJokes Method when the user scrolls just past the buttom of the tableView
        if (offsetY > contentHeight - scrollView.frame.height * 0.99) && !isLoading {
            
            isLoading = true
            topLabel.isHidden = false
            RequestJoke(session: URLSession.shared).getMultipleJokes() { (resultArr, success) in
                if success {
                    self.jokeArr?.append(contentsOf: resultArr)
                    self.isLoading = false
                    self.topLabel.isHidden = true
                    self.tableView.reloadData()
                } else {
                    self.isLoading = false
                    self.topLabel.isHidden = true
                    self.presentAlert(title: "Error", message: resultArr[0])
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JokeCell
            cell.jokeLabel.text = jokeArr![indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
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
