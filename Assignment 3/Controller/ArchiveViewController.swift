//
//  ArchiveViewController.swift
//  Assignment 3
//
//  Created by Pan Li on 15/5/2023.
//

import UIKit

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.archivedPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let plan = DataStore.shared.archivedPlans[indexPath.row]
        //let idLabel = cell.viewWithTag(idTag) as? UILabel
        
        if let planNameLabel = cell.viewWithTag(planNameTag) as? UILabel {
            planNameLabel.text = plan.planName
        }
        
        if let amountLabel = cell.viewWithTag(amountTag) as? UILabel {
            amountLabel.text = String(plan.amount)
        }
        
        if let idLabel = cell.viewWithTag(payTag) as? UILabel {
            idLabel.text = String(plan.paymentType)
        }
        
        if let idLabel = cell.viewWithTag(timeTag) as? UILabel {
            idLabel.text = String(plan.transactionTime)
        }

        return cell
        
    }
    

    let planNameTag = 100
    let amountTag = 101
    let payTag = 102
    let timeTag = 103
    
    @IBOutlet weak var moneyArchivesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyArchivesTable.delegate = self
        moneyArchivesTable.dataSource = self

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
