import UIKit

class ProfileViewController: UITableViewController {
    // Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var occupationTextField: UITextField!
    
    @IBOutlet weak var employerTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var jobExperienceTextView: UITextView!
    
    @IBOutlet weak var educationTextView: UITextView!
    
    @IBOutlet weak var skillsTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
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

        // Update text fields
        usernameTextField.isUserInteractionEnabled = isEditing
        occupationTextField.isUserInteractionEnabled = isEditing
        employerTextField.isUserInteractionEnabled = isEditing
        locationTextField.isUserInteractionEnabled = isEditing
        emailTextField.isUserInteractionEnabled = isEditing
        phoneNumberTextField.isUserInteractionEnabled = isEditing

        // Update text views
        jobExperienceTextView.isEditable = isEditing
        educationTextView.isEditable = isEditing
        skillsTextView.isEditable = isEditing
        jobExperienceTextView.isUserInteractionEnabled = isEditing
        educationTextView.isUserInteractionEnabled = isEditing
        skillsTextView.isUserInteractionEnabled = isEditing

        // Debugging prints
        print("jobExperienceTextView isEditable: \(jobExperienceTextView.isEditable)")
        print("educationTextView isEditable: \(educationTextView.isEditable)")
        print("skillsTextView isEditable: \(skillsTextView.isEditable)")

        // Update UI appearance
        let fontColor: UIColor = isEditing ? .red : .black
        let backgroundColor: UIColor = isEditing ? .red.withAlphaComponent(0.1) : UIColor(red: 55/255.0, green: 89/255.0, blue: 156/255.0, alpha: 1.0)

        usernameTextField.textColor = fontColor
        occupationTextField.textColor = fontColor
        employerTextField.textColor = fontColor
        locationTextField.textColor = fontColor
        emailTextField.textColor = fontColor
        phoneNumberTextField.textColor = fontColor

        jobExperienceTextView.backgroundColor = backgroundColor
        educationTextView.backgroundColor = backgroundColor
        skillsTextView.backgroundColor = backgroundColor

        // Toggle buttons
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

    @IBAction func saveButtonTapped(_ sender: UIButton) {
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
