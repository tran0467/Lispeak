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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var numberView: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var field: UITextField!
    
    var activeTextField:UITextField!
    
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
            
            textView.text = ""
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
        field.delegate = self
        
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name:  UIResponder.keyboardDidHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardShown(notification:Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardsize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardsize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to:self.view).minY;
        if self.view.frame.minY>=0 {
            if editingTextFieldY>keyboardY-50 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y-(editingTextFieldY-(keyboardY-100)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardHidden(notification:Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
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

extension ListeningViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
