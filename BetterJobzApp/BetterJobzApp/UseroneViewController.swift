//
//  UseroneViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-15 on 27/12/2024.
//

import UIKit

class UseroneViewController: UIViewController {

        
        var jobData: jmpstructlist?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Access the jobData and use it, for example, setting labels or displaying information
            if let job = jobData {
                // Update UI with job data
                print("Job Name: \(job.name)")
                // Example: You can assign job data to labels, like:
                // nameLabel.text = job.name
            }
            
            // Add back button
            let backButton = UIButton(type: .system)
            backButton.setTitle("Back", for: .normal)
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            backButton.frame = CGRect(x: 20, y: 40, width: 60, height: 30)
            view.addSubview(backButton)
        }

        @objc func backButtonTapped() {
            // Navigate back to JoblistViewController
            navigationController?.popViewController(animated: true)
        }
    }

