//
//  MusicViewController.swift
//  Project_iOS_TicTacToe
//
//  Created by Xcode User on 2018-04-24.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    var soundPlayer : AVAudioPlayer?
    
    @IBOutlet weak var displayLbl: UILabel!
    @IBOutlet var volSlider: UISlider!
    @IBOutlet var lbVol: UILabel!
        
    func volLabel(){
        let valueVol = volSlider.value
        let stringVol = String(format: "%.0f", valueVol)
        lbVol.text = stringVol
    }
    
   
    @IBAction func valValueSlider(_ sender: UISlider) {
      volLabel()
    }
    
    @IBAction func volumeDidChange(_ sender: UISlider) {
        soundPlayer?.volume = volSlider.value
    }
    
   @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.youtube.com/user/tobuofficial")
        myWebView.loadRequest(URLRequest(url: url!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        let soundURL = Bundle.main.path(forResource: "Tobu - Higher", ofType: "mp3")
        let url = URL(fileURLWithPath: soundURL!)
        
        do{
            self.soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
            self.soundPlayer?.currentTime = 0
            self.soundPlayer?.volume = self.volSlider.value
            self.soundPlayer?.numberOfLoops = -1
            self.soundPlayer?.play()
            displayLbl.text = "\(soundPlayer?.currentTime ?? 0)"
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
                (timer) in self.displayLbl.text = "\(round((self.soundPlayer?.currentTime)!*10)/10)"
            })
            
        }
        soundPlayer?.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        soundPlayer?.stop()
    }
    
    @IBAction func pressedPause(_ sender: UIButton) {
             soundPlayer?.pause()
    }
   
    @IBAction func pressedStop(_ sender: UIButton) {
        soundPlayer?.stop()
        soundPlayer?.currentTime = 0
    }
}
