//
//  ViewController.swift
//  DataPicker
//
//  Created by Lokesh Gupta on 5/31/19.
//  Copyright © 2019 Lokesh Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CustomPickerDelegate,UITextFieldDelegate {
   
    
    var committedStoredData = [Any]()
   // var dataArr = [["England","India","Afghanistan","South Africa","Pakistan","Bangladesh","West Indies","Australia"],["Asia","Africa","Europe","Australia"],["Warm","Cold"]]
    var dataArr = [["England","India","Afghanistan","South Africa","Pakistan","Bangladesh","West Indies","Australia"]]
    @IBOutlet weak var val1Lab: UILabel!
    @IBOutlet weak var val2Lab: UILabel!
    @IBOutlet weak var val3Lab: UILabel!
    @IBOutlet weak var customTextF: PickerInpuTF!
    @IBOutlet weak var dateTextF: PickerInpuTF!
    var selectedTextF: PickerInpuTF!

    func doneTapped(data: Any, type: PickerType) {
        if type == PickerType.DateOpt {
            self.selectedTextF.data = data as! [Any]
            self.selectedTextF.text = (self.selectedTextF.data[0] as! String)

        }
        else {
            //self.committedStoredData = (data as! [Any])
            self.selectedTextF.data = data as! [Any]

            for (index, listObj) in self.selectedTextF.parentData.enumerated() {
                
                if index == 0 {
                    self.selectedTextF.text = listObj[self.selectedTextF.data[index] as! Int] as? String
                }
                else if index == 1 {
                    self.val2Lab.text = listObj[self.selectedTextF.data[index] as! Int] as? String
                }
                else {
                    self.val3Lab.text = listObj[self.selectedTextF.data[index] as! Int] as? String
                }
                
            }
        }
        
    }
    
    func cancelTapped(data: Any) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customTextF.parentData = dataArr
        customTextF.data = [Any](repeating: 0, count: customTextF.parentData.count)
        dateTextF.data = [Any](repeating: 0, count: 1)
        committedStoredData = [Any](repeating: 0, count: 1)
    }

    @IBAction func buttonClicked(_ sender: Any) {
        performSegue(withIdentifier: "select_data", sender: sender)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextF = (textField as! PickerInpuTF)
        self.performSegue(withIdentifier: "select_data", sender: self)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "select_data" {
            
            let selectCountryVC = segue.destination as! SelectViewController
            
            selectCountryVC.providesPresentationContextTransitionStyle = true
            selectCountryVC.definesPresentationContext = true
            selectCountryVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            selectCountryVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            selectCountryVC.delegate = self
            if selectedTextF == self.dateTextF {
                selectCountryVC.type = PickerType.DateOpt
            }
            //selectCountryVC.dataArray = [["England","India","Afghanistan","South Africa","Pakistan","Bangladesh","West Indies","Australia"],["Asia","Africa","Europe","Australia"],["Warm","Cold"]]
            selectCountryVC.dataArray = self.selectedTextF.parentData as! [[String]]
            selectCountryVC.committedStoredData = self.selectedTextF.data
            print("Segue Performing")
        }
    }
    
}

