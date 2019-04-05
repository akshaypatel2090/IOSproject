//
//  GameViewController.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit
import AVFoundation

class GameViewController: UIViewController {
    
    var type: GameType? = nil
    var soundPlayer : AVAudioPlayer?
    
    lazy var skView: SKView = {
        guard let skView = self.view as? SKView else { fatalError() }
        return skView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let soundURL = Bundle.main.path(forResource: "Tobu - Higher", ofType: "mp3")
        let url = URL(fileURLWithPath: soundURL!)
        
        self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        self.soundPlayer?.currentTime = 0
        self.soundPlayer?.numberOfLoops = -1
        self.soundPlayer?.play()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        soundPlayer?.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let type = type else { fatalError("expected game type") }
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        switch type {
        case .onePlayer:
            let size = skView.frame.size
            let scene = GameScene(size: size, type: .onePlayer)
            scene.presentationDelegate = self
            
            self.skView.presentScene(scene)
        case .twoPlayer:
         //   setupTwoPlayerGame()
            let size = skView.frame.size
            let scene = GameScene(size: size, type: .twoPlayer)
            scene.presentationDelegate = self
            
            self.skView.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: ScenePresentationDelegate {
    func shouldDismissScene(_ scene: SKScene) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension GameViewController: GKTurnBasedMatchmakerViewControllerDelegate {
    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
