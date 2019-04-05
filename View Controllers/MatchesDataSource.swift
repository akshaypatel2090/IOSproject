//
//  MatchesDataSource.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import UIKit
import GameKit

typealias LoadedMatchesCompletion = ([GKTurnBasedMatch]?, Error?) -> Void

class MatchesDataSource: NSObject {
    private(set) var matches: [AnyObject] = []
    
    func loadMatches(completion: @escaping LoadedMatchesCompletion) -> Void {
        GKTurnBasedMatch.loadMatches { (matches, error) in
            completion(matches, error)
        }
    }
}
