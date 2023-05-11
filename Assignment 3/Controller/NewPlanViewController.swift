//
//  NewPlanViewController.swift
//  Assignment 3
//
//  Created by vinay bayyapunedi on 10/05/23.
//

import Foundation
import UIKit

class NewPlanViewController: UIViewController {
    
    
    var planType:String?
    
    
    @IBOutlet weak var planTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planTypeLabel.text = planType
        
    }


}
