//
//  AllowanceViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class AllowanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //https://codewithchris.com/uipickerview-example/ - refer to this for VIewPicker
    
    
    @IBOutlet weak var timeFrameDropDown: UIPickerView!
    
    @IBOutlet weak var noteInputTextField: UITextField!
    
    var timeFrame: String?
    
    var list : [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeFrameDropDown.delegate = self
        self.timeFrameDropDown.dataSource = self
        
        list  = ["Daily", "Weekly", "Monthly"]
        
        timeFrameDropDown.selectRow(DataStore.shared.timeSelecterLocation, inComponent: 0, animated: true)
        
//        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return list.count
    }
    
    // The data to return for the row and component (column) thats being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return list[row]
    }
    
    func pickerView(_ pickerView:UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // This method is triggered whenever the user makes a change to the picker selection
        // The parameter named row and componment represents what we selected
        
        timeFrame = String(list[row])
        
        DataStore.shared.timeframe = timeFrame!
        DataStore.shared.timeSelecterLocation = row
        
    }

    @IBAction func saveChangeButtonPressed(_ sender: UIButton) {
//        DataStore.shared.timeframe = timeFrame!
//        DataStore.shared.timeSelecterLocation = row
        
        DataStore.shared.allowanceNote = noteInputTextField.text
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
