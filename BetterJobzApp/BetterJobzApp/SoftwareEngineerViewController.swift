//
//  SoftwareEngineerViewController.swift
//  Dashboard
//
//  Created by aya on 19/12/2024.
//

import UIKit

class SoftwareEngineerViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Apply(_ sender: UIButton) {
        // Save the identifier for the current status page in UserDefaults
            let userDefaults = UserDefaults.standard
            userDefaults.set("SoftwareEngineerStatusSegue", forKey: "lastAppliedPage")

            // Navigate to the status page
            performSegue(withIdentifier: "SoftwareEngineerStatusSegue", sender: self)
        }

    
    @IBAction func notInterestedButtonTapped(_ sender: Any) {
        // Navigate back to the previous view controller (Dashboard)
            navigationController?.popViewController(animated: true)
        }
    

}
