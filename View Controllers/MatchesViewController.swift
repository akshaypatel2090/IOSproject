//
//  MatchesViewController.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import UIKit
import GameKit

class MatchesViewController: UIViewController {
    
    let dataSource = MatchesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.loadMatches { (matches, error) in
            //
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
