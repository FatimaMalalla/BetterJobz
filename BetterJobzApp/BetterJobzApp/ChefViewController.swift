//
//  ChefViewController.swift
//  Dashboard
//
//  Created by aya on 19/12/2024.
//

import UIKit

class ChefViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Apply(_ sender: UIButton) {
        
             let segueIdentifier = "ChefStatusSegue" // Replace with the correct identifier for this job
             let userDefaults = UserDefaults.standard
             userDefaults.set(segueIdentifier, forKey: "lastAppliedPage")
             
             // Attempt to perform the segue
             if canPerformSegue(withIdentifier: segueIdentifier) {
                 performSegue(withIdentifier: segueIdentifier, sender: self)
             } else {
                 // Show an alert if the segue is missing
                 let alert = UIAlertController(
                     title: "Error",
                     message: "Unable to navigate to the status page. Please check the app setup.",
                     preferredStyle: .alert
                 )
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 present(alert, animated: true, completion: nil)
             }
         }

         // Helper method to check if a segue exists
         func canPerformSegue(withIdentifier identifier: String) -> Bool {
             return (self.value(forKey: "storyboardSegueTemplates") as? [NSObject])?.contains {
                 $0.value(forKey: "identifier") as? String == identifier
             } ?? false
         }
    
    
    @IBAction func notInterestedButtonTapped(_ sender: Any) {
        // Navigate back to the previous view controller (Dashboard)
            navigationController?.popViewController(animated: true)
        }
    
}

