//
//  ViewController.swift
//  CodingMentor
//
//  Created by Mac on 9/3/21.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import Combine



class ViewController: UIViewController {
    
//let tasks = [
//    "Deceive heavens into trusting one does not cross the sea",
//    "Besiege Wèi to rescue Zhào",
//    "Kill with a borrowed knife",
//    "Be prepared and wait for the exhausted enemy",
//    "Loot a burning property",
//    "Make a sound in the east, then strike in the west",
//    "Create something from nothing",
//    "Openly chisel a tunnel in the steep precipice, but clandestinely go through an easy path",
//    "Watch fires burning on the other bank of the river",
//    "Hide a knife within a smile",
//    "Sacrifice the plum tree to preserve the peach tree",
//    "Take the opportunity to pilfer a goat",
//    "Stomp the grass to scare the snake",
//    "Borrow a corpse to resurrect the soul",
//    "Lure the tiger off its mountain lair",
//    "In order to capture, one must let loose",
//    "Tossing out a brick to get a jade gem",
//    "Defeat the enemy by capturing their chief",
//    "Remove the firewood from under the pot",
//    "Disturb the water and catch a fish",
//    "Slough off the cicada's golden shell",
//    "Shut the door to catch the thief",
//    "Befriend a distant state and strike a neighbouring one",
//    "Obtain safe passage to conquer the State of Guo",
//    "Replace the beams with rotten timbers",
//    "Point at the mulberry tree while cursing the locust tree",
//    "Feign madness but keep your balance",
//    "Remove the ladder when the enemy has ascended to the roof",
//    "Decorate the tree with false blossoms",
//    "Make the host and the guest exchange roles",
//    "The beauty trap",
//    "The empty fort strategy",
//    "Let the enemy's own spy sow discord in the enemy camp",
//    "Inflict injury on oneself to win the enemy's trust",
//    "Chain stratagems",
//    "If all else fails, retreat"
//]
    
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var num: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var againButton: UIButton!
    
    
    
    
    @IBAction func tap(_ sender: Any) {
        print("hello")
    }
    
    func speak(sentence:String){
    let utterance = AVSpeechUtterance(string: sentence)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
    utterance.rate = 0.5

    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
    }
    
    var count = 0
    
    @IBAction func next(_ sender: Any) {
        count += 1
        if (count > tasks.count){
            count = 1
        }
        print(tasks[count])
        label.text = tasks[count-1]
        num.text = "\(count)"
        
        self.label.alpha = 0

        UIView.animate(withDuration: 1.0, animations: {
            self.label.alpha = 1.0
        })
        
        speak(sentence: tasks[count-1])
    }
    
    
    @IBAction func Again(_ sender: Any) {
        self.label.alpha = 0

        UIView.animate(withDuration: 1.0, animations: {
            self.label.alpha = 1.0
        })
        
        speak(sentence: tasks[count-1])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

