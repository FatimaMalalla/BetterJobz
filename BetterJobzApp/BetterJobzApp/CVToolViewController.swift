//  CVToolViewController.swift
//  BetterJobzApp

import UIKit
import PDFKit
import FirebaseAuth
import FirebaseDatabase

class CVToolViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load user data from Firebase
       // loadUserData()
        loadCVData()
    }
    
  
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var educationTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
  
    let databaseRef = Database.database().reference()
    var userUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    private func loadUserData() {
        guard let userUID = userUID else { return }
        
        // Fetch user data from the root node
        databaseRef.child("users").child(userUID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No data found for user.")
                return
            }
            
            // Check for fullName under root node
            if let fullName = userData["fullName"] as? String {
                self.fullNameTxtField.text = fullName
            }
            
            // Populate other fields
            self.emailTextField.text = userData["email"] as? String
            self.languageTextField.text = userData["language"] as? String
            self.educationTextField.text = userData["education"] as? String
            self.occupationTextField.text = userData["occupation"] as? String
            self.phoneNumberTextField.text = userData["phoneNumber"] as? String
        }
    }

    private func loadCVData() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User UID not found.")
            return
        }
        
        let databaseRef = Database.database().reference()
        databaseRef.child("users").child(userUID).child("cv").observeSingleEvent(of: .value) { snapshot in
            print("Snapshot: \(snapshot.value ?? "No data found")") // Debug print

            guard let cvData = snapshot.value as? [String: Any] else {
                print("No CV data found.")
                return
            }
            
            // Assign values to the text fields
            self.fullNameTxtField.text = cvData["fullName"] as? String ?? ""
            self.emailTextField.text = cvData["email"] as? String ?? ""
            self.languageTextField.text = cvData["language"] as? String ?? ""
            self.educationTextField.text = cvData["education"] as? String ?? ""
            self.occupationTextField.text = cvData["occupation"] as? String ?? ""
            self.phoneNumberTextField.text = cvData["phoneNumber"] as? String ?? ""
        }
    }



    @IBAction func SaveBttnTapped(_ sender: UIButton) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        // Collect CV data
        let cvData: [String: Any] = [
            "fullName": fullNameTxtField.text ?? "",
            "email": emailTextField.text ?? "",
            "language": languageTextField.text ?? "",
            "education": educationTextField.text ?? "",
            "occupation": occupationTextField.text ?? "",
            "phoneNumber": phoneNumberTextField.text ?? ""
        ]
        
        // Save CV data under the "cv" key
        databaseRef.child("users").child(userUID).child("cv").setValue(cvData) { error, _ in
            if let error = error {
                print("Failed to save CV: \(error.localizedDescription)")
            } else {
                print("CV data saved successfully!")
            }
        }
    }
    
    @IBAction func generateCVButtonTapped(_ sender: UIButton) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        // Fetch user data from Firebase
        databaseRef.child("users").child(userUID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No user data found.")
                return
            }
            
            // Retrieve and format the CV content
            let fullName = userData["fullName"] as? String ?? "N/A"
            let aboutMe = userData["aboutMe"] as? String ?? "N/A"
            let cvData = userData["cv"] as? [String: Any] ?? [:]
            let skills = userData["skills"] as? [String] ?? []
            let interests = userData["interests"] as? [String] ?? []
            let workExperience = userData["workExperience"] as? [String] ?? []
            
            let formattedCV = self.formatCVContent(
                fullName: fullName,
                aboutMe: aboutMe,
                cvData: cvData,
                skills: skills,
                interests: interests,
                workExperience: workExperience
            )
            
            // Perform segue and pass the CV content
            self.performSegue(withIdentifier: "showGeneratedCVSegue", sender: formattedCV)
        }
    }
    
    private func formatCVContent(fullName: String, aboutMe: String, cvData: [String: Any], skills: [String], interests: [String], workExperience: [String]) -> NSAttributedString {
//        let email = cvData["email"] as? String ?? "N/A"
//        let language = cvData["language"] as? String ?? "N/A"
//        let education = cvData["education"] as? String ?? "N/A"
//        let occupation = cvData["occupation"] as? String ?? "N/A"
//        let phoneNumber = cvData["phoneNumber"] as? String ?? "N/A"
        
        // Define the font and styles
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        //let regularFont = UIFont.systemFont(ofSize: 14)
        let centerAlign = NSMutableParagraphStyle()
        centerAlign.alignment = .center
        
        let formattedCV = NSMutableAttributedString()
        
        // Full Name (Center Aligned)
        let fullNameTitle = NSAttributedString(string: "\(fullName)\n\n", attributes: [.font: boldFont, .paragraphStyle: centerAlign])
        formattedCV.append(fullNameTitle)
        
        // Remaining CV content
        // (Add other sections like "About Me", "Skills", etc., similar to the original implementation.)
        
        return formattedCV
    }
}
