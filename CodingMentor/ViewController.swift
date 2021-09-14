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
import Speech


class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
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
    
    @IBOutlet weak var speakButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task2 : SFSpeechRecognitionTask!
    var isStart : Bool = false
    
    
    func requestPermission() {
        self.speakButton.isEnabled = false
        SFSpeechRecognizer.requestAuthorization { (authState) in
            OperationQueue.main.addOperation {
                if authState == .authorized{
                    print("ACCEPTED")
                    self.speakButton.isEnabled = true
                }else if authState == .denied {
                    self.alertView(message: "User denied the permission")
                }else if authState == .notDetermined {
                    self.alertView(message: "In User's phone, there is no speech regonization")
                }else if authState == .restricted {
                    self.alertView(message: "User has been restricted for restricted for using the speech recognization")
                }
            }
        }
    }
    
    func alertView(message : String) {
        let controller = UIAlertController.init(title: "Error occured...!", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in controller.dismiss(animated: true, completion: nil)} ))
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func tapSpeakButton(_ sender: Any) {
        requestPermission()
        isStart = !isStart
        
        if isStart {
            startSpeechRecognization()
            speakButton.setTitle("STOP", for: .normal)
            speakButton.backgroundColor = .systemGreen
        } else {
            cancelSpeechRecognization()
            speakButton.setTitle("START", for: .normal)
            speakButton.backgroundColor = .systemRed
        }
    }
    
    var message = ""
    
    func startSpeechRecognization() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            alertView(message: "Error for starting the audio listener = \(error.localizedDescription)")
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            self.alertView(message: "Recognization is not allow on your local")
            return
        }
        if !myRecognization.isAvailable {
            self.alertView(message: "Recognization is not avaiable, please try again")
        }
        task2 = speechRecognizer?.recognitionTask(with: request, resultHandler: { (response, error) in
            guard let response = response else {
                if error != nil {
                    self.alertView(message: error.debugDescription)
                } else {
                    self.alertView(message: "Problem in giving the response")
                }
                return
            }
            
            self.message = response.bestTranscription.formattedString
            
        })
    }
    
    func cancelSpeechRecognization() {
        task2.finish()
        task2.cancel()
        task2 = nil
        
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        print(message)
        
        if (message == tasks[count-1]) {
            label.text = "Perfect!"
        } else {
            label.text = "Incorrect"
        }
        
    }
    
    @IBAction func tap(_ sender: Any) {
        print("hello")
    }
    
    func speak(sentence:String){
    let utterance = AVSpeechUtterance(string: sentence)
    utterance.voice = AVSpeechSynthesisVoice(language: accent)
        utterance.rate = speed

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
        label.text = tasks[count-1]
        speak(sentence: tasks[count-1])
    }
    
    
    @IBAction func Again(_ sender: Any) {
        self.label.alpha = 0
        label.text = tasks[count-1]
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

