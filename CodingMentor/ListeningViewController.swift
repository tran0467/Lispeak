//
//  ListeningViewController.swift
//  CodingMentor
//
//  Created by Mac on 9/14/21.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class ListeningViewController: UIViewController {

    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var field: UITextField!
    
    
    
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
    //        print(tasks[count])
//            textView.text = tasks[count-1]
            numberView.text = "\(count)"
            
//            self.textView.alpha = 0
//
//            UIView.animate(withDuration: 1.0, animations: {
//                self.textView.alpha = 1.0
//            })
            
            speak(sentence: tasks[count-1])
            textView.text = ""
            
        }
        
        
        @IBAction func Again(_ sender: Any) {
            self.textView.alpha = 0

            UIView.animate(withDuration: 1.0, animations: {
                self.textView.alpha = 1.0
            })
//            textView.text = tasks[count-1]
            speak(sentence: tasks[count-1])
        }
    
    @IBAction func submitAnswer(_ sender: Any) {
        let mtext = field.text
        if (mtext == tasks[count-1]) {
            textView.text = "Correct!"
        } else {
            textView.text = "Incorrect"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
