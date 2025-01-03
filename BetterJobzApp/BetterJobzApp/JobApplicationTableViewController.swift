//
//  JobApplicationTableViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-224-14 on 27/12/2024.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class JobApplicationTableViewController: UITableViewController {
    
    //Current Work Experience
    
    @IBOutlet weak var currentJobTitle: UITextField!
    @IBOutlet weak var currentEmployerName: UITextField!
    @IBOutlet weak var currentJobDesc: UITextField!
    
    //Previous Work Experience
    
    @IBOutlet weak var previousJobTitle: UITextField!
    @IBOutlet weak var previousEmployerName: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var previousJobDesc: UITextField!
    
    //Qualifications
    
    @IBOutlet weak var skills: UITextField!
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var certifications: UITextField!
    @IBOutlet weak var yearsOfExperience: UITextField!
    
    //Cover letter
    @IBOutlet weak var letterOfIntent: UITextField!
    
    
    var ref: DatabaseReference!
    var userID: String = "" // To be dynamically set after login
    
    /// Displays an alert with a title, message, and an action button.
    func showAlert(title: String, message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            // Call the completion handler if provided
            completion?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Assign user ID after login
        if let currentUserID = Auth.auth().currentUser?.uid {
            self.userID = currentUserID
        } else {
            showAlert(title: "Error", message: "User not logged in.")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    // Employed Next button
    @IBAction func NextButtonTapped(_ sender: Any) {
        guard let jobTitle = currentJobTitle.text, !jobTitle.isEmpty,
              let employerName = currentEmployerName.text, !employerName.isEmpty,
              let description = currentJobDesc.text, !description.isEmpty
        else {
            showAlert(title: "Error", message: "All fields are required.")
            return
        }
        let jobApplicationData: [String: Any] = [
            "Current Job Title": jobTitle,
            "Current Employer Name": employerName,
            "Description of Current Job": description
        ]
        
        
        ref.child("users").child(userID).child("job_details").child("Current_Job_Details").setValue(jobApplicationData)
    }
    
    // Unemployed Next button
    @IBAction func unemployedNextButtonTapped(_ sender: Any) {
        guard let pJobTitle = previousJobTitle.text, !pJobTitle.isEmpty,
              let pEmployerName = previousEmployerName.text, !pEmployerName.isEmpty,
              let start = startDate.text, !start.isEmpty,
              let end = endDate.text, !end.isEmpty,
              let pDescription = previousJobDesc.text, !pDescription.isEmpty
        else{
            showAlert(title: "Error", message: "All fields are required.")
            return
        }
        let jobApplicationData: [String: Any] = [
            "Previous Job Title": pJobTitle,
            "Previous Employer Name": pEmployerName,
            "Start Date": start,
            "End Date": end,
            "Description of Previous Job": pDescription
        ]
        
        ref.child("users").child(userID).child("job_details").child("Previous_Job_Details").setValue(jobApplicationData){ error, _ in
            if let error = error {
                // Show error if Firebase save fails
                self.showAlert(title: "Error", message: "Failed to save data: \(error.localizedDescription)")
            } else {
                // Perform segue only if data is saved successfully
                self.performSegue(withIdentifier: "next", sender: nil)
            }
        }
    }
    
    // Qualification Next button
    @IBAction func qualificationNextButtonTapped(_ sender: Any) {
        // Validate all fields
            guard let skillBox = skills.text, !skillBox.isEmpty,
                  let educationBox = education.text, !educationBox.isEmpty,
                  let certificationsBox = certifications.text, !certificationsBox.isEmpty,
                  let yearsOfExperienceBox = yearsOfExperience.text, !yearsOfExperienceBox.isEmpty
            else {
                // Show alert and stop further action
                showAlert(title: "Error", message: "All fields are required.")
                return
            }
            
            // Prepare data to save
            let jobApplicationData: [String: Any] = [
                "Skills": skillBox,
                "Education": educationBox,
                "Certifications": certificationsBox,
                "Years of Experience": yearsOfExperienceBox
            ]
            
            // Save data to Firebase
            ref.child("users").child(userID).child("job_details").child("Qualifications_Details").setValue(jobApplicationData) { error, _ in
                if let error = error {
                    // Show error if Firebase save fails
                    self.showAlert(title: "Error", message: "Failed to save data: \(error.localizedDescription)")
                } else {
                    // Perform segue only if data is saved successfully
                    self.performSegue(withIdentifier: "quali", sender: nil)
                }
            }
    }
    
    // Cover letter finish button
    @IBAction func coverLetterFinishButtonTapped(_ sender: Any) {
        guard let letterOfIntentBox = letterOfIntent.text,
              !letterOfIntentBox.isEmpty
        else{
            showAlert(title: "Error", message: "All fields are required.")
            return
            }
        
        let jobApplicationData: [String: Any] = [
            "Letter of Intent": letterOfIntentBox
            ]
        
        ref.child("users").child(userID).child("job_details").child("Letter_of_Intent").setValue(jobApplicationData){ error, _ in
            if let error = error {
                // Show error alert if saving fails
                self.showAlert(title: "Error", message: "Failed to save data: \(error.localizedDescription)")
            } else {
                // Show success alert
                let alert = UIAlertController(title: "Success", message: "Your application has been successfully submitted.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    // Perform segue after user taps "OK"
                    self.performSegue(withIdentifier: "done", sender: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    
    
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
