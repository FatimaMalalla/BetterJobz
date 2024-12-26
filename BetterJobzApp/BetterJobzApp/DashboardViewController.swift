//
//  DashboardViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-07 on 26/11/2024.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    var username: String? // Optional property to pass data

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func jobApplicationStatusButtonTapped(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if let lastAppliedPage = userDefaults.string(forKey: "lastAppliedPage") {
            performSegue(withIdentifier: lastAppliedPage, sender: self)
        } else {
            let alert = UIAlertController(
                title: "No Applications Found",
                message: "You have not applied for any job yet.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    

}
