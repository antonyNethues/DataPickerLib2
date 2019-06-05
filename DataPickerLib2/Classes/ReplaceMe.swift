
//
//  SelectCountryViewController.swift
//  DataSendSwift
//
//  Created by Lokesh Gupta on 5/23/19.
//  Copyright © 2019 Lokesh Gupta. All rights reserved.
//

import UIKit

extension UIView{
    
    func animShow(){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
                       animations: {
                        //                        self.center.y -= self.bounds.height
                        self.center.y -= self.bounds.height
                        
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    
    func animShow(withConstraint:NSLayoutConstraint){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
                       animations: {
                        //                        self.center.y -= self.bounds.height
                        //                        self.frame.origin.y = self.frame.maxY - self.bounds.height
                        withConstraint.constant = 10
                        
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                       animations: {
                        //                        self.center.y += self.bounds.height
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    func animHide(withConstraint:NSLayoutConstraint) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                       animations: {
                        //                        self.center.y += self.bounds.height
                        //                        self.frame.origin.y = self.frame.maxY + self.bounds.height
                        withConstraint.constant = -self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    func animHide(completion: @escaping (Bool?) -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                       animations: {
                        //                        self.center.y += self.bounds.height
                        self.frame.origin.y = self.frame.maxY + self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
            completion(true)
        })
    }
    
    func animTranslateShow(){
        UIView.transition(with: self,
                          duration: 0.5,
                          options: [.transitionCurlUp],
                          animations: {
                            
                            self.layoutIfNeeded()
                            
        },
                          completion: nil)
        self.isHidden = false
    }
}
//MARK:-
protocol CustomPickerDelegate : class {
    func doneTapped(data : AnyObject)
    func cancelTapped(data : AnyObject)
}
class SelectViewController: UIViewController {
    
    @IBOutlet weak var rootView: UIView!
    weak var delegate : CustomPickerDelegate!
    
    @IBOutlet weak var customPickerView: UIPickerView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var pickerTitle:String! = ""
    
    var dataArray = [[String]]()
    
    var oldStoredData = [Int]()
    var committedStoredData = [Int]()
    
    @IBOutlet weak var constrRootViewBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        // Do any additional setup after loading the view.
        
        //self.rootView.animTranslateShow()
        
        if pickerTitle.count != 0 {
            labelTitle.text = pickerTitle
        }
        rootView.translatesAutoresizingMaskIntoConstraints = false
        
        //        rootView.alpha = 0;
        //        rootView.isHidden = true
        //        self.rootView.frame.origin.y = self.rootView.frame.origin.y + 200
        //        UIView.animate(withDuration: 5, animations: { () -> Void in
        //            self.rootView.alpha = 1.0;
        //            self.rootView.frame.origin.y = self.rootView.frame.origin.y - 200
        //            self.rootView.isHidden = false
        //            self.rootView.translatesAutoresizingMaskIntoConstraints = false
        //        })
        
        rootView.animHide()
        //        rootView.animHide(withConstraint: constrRootViewBottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.rootView.animShow()
            //            self.rootView.animShow(withConstraint: self.constrRootViewBottom)
        }
        
        oldStoredData = self.committedStoredData
        //committedStoredData = [Int](repeating: 0, count: dataArray.count)
        for (index, _) in dataArray.enumerated() {
            self.customPickerView.selectRow(self.committedStoredData[index], inComponent: index, animated: true)
            self.customPickerView.reloadAllComponents()
        }
        
    }
    
    /*
     // MARK:  Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func doneClicked(_ sender: Any) {
        for (index, _) in dataArray.enumerated() {
            self.committedStoredData[index] = self.customPickerView.selectedRow(inComponent: index)
        }
        self.delegate.doneTapped(data: self.committedStoredData as AnyObject)
        // self.delegate.doneTapped(data: self.)
        rootView.animHide { (completed) in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancelClicked(_ sender: Any) {
        self.delegate.cancelTapped(data: self.committedStoredData as AnyObject)
        
        rootView.animHide { (completed) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}




extension SelectViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dataArray[component][row])
    }
}
