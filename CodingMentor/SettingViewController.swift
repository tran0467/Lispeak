//
//  SettingViewController.swift
//  CodingMentor
//
//  Created by Mac on 9/14/21.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit

var accent:String = ""
var speed:Float = 0.5

class SettingViewController: UIViewController {

    @IBOutlet weak var accentPicker: UIPickerView!
    
    let data = ["en-GB","en-AU","en-US"]
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var stepperButton: UIStepper!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func pressStepper(_ sender: UIStepper) {
        stepperButton.stepValue = 0.1
        speedLabel.text = String(sender.value)
    }
    
    @IBAction func pressSaveButton(_ sender: Any) {
        accent = data[accentPicker.selectedRow(inComponent: 0)]
        print (accent)
        speed = Float(speedLabel.text!)!
        print (speed)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accentPicker.dataSource = self
        accentPicker.delegate = self
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

extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
