//
//  ProfileViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 19/12/2024.
//

import UIKit

class ProfileViewController: UIViewController {

          
        @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var usernameTextField: UITextField!
        @IBOutlet weak var occupationTextField: UITextField!
        @IBOutlet weak var employerTextField: UITextField!
        @IBOutlet weak var locationTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField
        @IBOutlet weak var phoneNumberTextField: UITextField!
        @IBOutlet weak var jobExperienceTextView: UITextView!
        @IBOutlet weak var educationTextView: UITextView!
        @IBOutlet weak var skillsTextView: UITextView!
        
        
        var isInEditMode = false

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
                loadUserData() // Load data when the app starts
        }
        
        func loadUserData() {
            let defaults = UserDefaults.standard

            usernameTextField.text = defaults.string(forKey: "username")
            occupationTextField.text = defaults.string(forKey: "occupation")
            employerTextField.text = defaults.string(forKey: "employer")
            locationTextField.text = defaults.string(forKey: "location")
            emailTextField.text = defaults.string(forKey: "email")
            phoneNumberTextField.text = defaults.string(forKey: "phoneNumber")
            jobExperienceTextView.text = defaults.string(forKey: "jobExperience")
            educationTextView.text = defaults.string(forKey: "education")
            skillsTextView.text = defaults.string(forKey: "skills")

            if let imageData = defaults.data(forKey: "profileImage"), let profileImage = UIImage(data: imageData) {
                profileImageView.image = profileImage
            }
        }

        
        func saveUserData() {
            let defaults = UserDefaults.standard

            defaults.set(usernameTextField.text, forKey: "username")
            defaults.set(occupationTextField.text, forKey: "occupation")
            defaults.set(employerTextField.text, forKey: "employer")
            defaults.set(locationTextField.text, forKey: "location")
            defaults.set(emailTextField.text, forKey: "email")
            defaults.set(phoneNumberTextField.text, forKey: "phoneNumber")
            defaults.set(jobExperienceTextView.text, forKey: "jobExperience")
            defaults.set(educationTextView.text, forKey: "education")
            defaults.set(skillsTextView.text, forKey: "skills")

            if let profileImage = profileImageView.image, let imageData = profileImage.pngData() {
                defaults.set(imageData, forKey: "profileImage")
            }

            defaults.synchronize()
            print("User data saved.")
        }

        
        
        

        func setupUI() {
            saveButton.isHidden = true // Initially hide the save button
            toggleEditingMode(isEditing: false)
            setupProfileImageTap()
        }

        func toggleEditingMode(isEditing: Bool) {
            isInEditMode = isEditing
            
            // Update UI elements
            usernameTextField.isUserInteractionEnabled = isEditing
            occupationTextField.isUserInteractionEnabled = isEditing
            employerTextField.isUserInteractionEnabled = isEditing
            locationTextField.isUserInteractionEnabled = isEditing
            emailTextField.isUserInteractionEnabled = isEditing
            phoneNumberTextField.isUserInteractionEnabled = isEditing
            jobExperienceTextView.isEditable = isEditing
            educationTextView.isEditable = isEditing
            skillsTextView.isEditable = isEditing
            
            // Change font colors and background colors to indicate edit mode
            let fontColor: UIColor = isEditing ? .red : .black
            let backgroundColor: UIColor = isEditing ? .red.withAlphaComponent(0.1) : .clear

            usernameTextField.textColor = fontColor
            occupationTextField.textColor = fontColor
            employerTextField.textColor = fontColor
            locationTextField.textColor = fontColor
            emailTextField.textColor = fontColor
            phoneNumberTextField.textColor = fontColor
            jobExperienceTextView.backgroundColor = backgroundColor
            educationTextView.backgroundColor = backgroundColor
            skillsTextView.backgroundColor = backgroundColor

            // Show or hide buttons
            saveButton.isHidden = !isEditing
            editButton.isHidden = isEditing
        }

        func setupProfileImageTap() {
            // Add tap gesture recognizer for profile picture
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
            profileImageView.addGestureRecognizer(tapGesture)
            profileImageView.isUserInteractionEnabled = true
        }

        @objc func profileImageTapped() {
            if isInEditMode {
                // Open ImagePickerViewController
                if let imagePickerVC = storyboard?.instantiateViewController(withIdentifier: "ImagePickerViewController") as? ImagePickerViewController {
                    imagePickerVC.delegate = self
                    present(imagePickerVC, animated: true, completion: nil)
                }
            }
        }

        // Actions
        @IBAction func editButtonTapped(_ sender: UIButton) {
            toggleEditingMode(isEditing: true)
        }

        @IBAction func saveButtonTapped(_ sender: UIButton) {toggleEditingMode(isEditing: false)
            // Save data (optional: persist it to UserDefaults or a database)
            print("User changes saved")
            toggleEditingMode(isEditing: false)
                saveUserData()
        }
        
    }

    // MARK: - ImagePickerDelegate
    extension ProfileViewController: ImagePickerDelegate {
        func didSelectProfileImage(_ image: UIImage?) {
            profileImageView.image = image // Update profile picture
        }
    }


}
