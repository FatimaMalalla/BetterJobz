import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    let databaseRef = Database.database().reference()
    var userUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    var isInEditMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCVData()       // Fetch and display details from the CV child
        loadProfileData()  // Fetch profile details from the profile child (if any)
    }
    
    // MARK: - Load CV Data
    private func loadCVData() {
        guard let userUID = userUID else {
            print("No user UID found")
            return
        }
        
        // Fetch CV data from Firebase
        databaseRef.child("users").child(userUID).child("cv").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self, let cvData = snapshot.value as? [String: Any] else {
                print("No CV data found.")
                return
            }
            
            // Populate text fields and text views from the CV child
            self.usernameTextField.text = cvData["fullName"] as? String ?? ""
            self.occupationTextField.text = cvData["occupation"] as? String ?? ""
            self.emailTextField.text = cvData["email"] as? String ?? ""
            self.phoneNumberTextField.text = cvData["phoneNumber"] as? String ?? ""
            self.educationTextView.text = cvData["education"] as? String ?? ""
            self.skillsTextView.text = cvData["language"] as? String ?? ""  // Assuming "skills" are mapped to "language" in the CV child
        }
    }
    
    // MARK: - Load Profile Data
    private func loadProfileData() {
        guard let userUID = userUID else {
            print("No user UID found")
            return
        }
        
        // Fetch profile data from the profile child
        databaseRef.child("users").child(userUID).child("profile").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self, let profileData = snapshot.value as? [String: Any] else {
                print("No profile data found.")
                return
            }
            
            // Populate additional profile details
            self.employerTextField.text = profileData["employer"] as? String
            self.locationTextField.text = profileData["location"] as? String
            
            // Optional: Handle profile image if stored
            if let profileImageUrl = profileData["profileImage"] as? String, let url = URL(string: profileImageUrl) {
                self.loadProfileImage(from: url)
            }
        }
    }
    
    private func loadProfileImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
    
    // MARK: - Save Profile Data
    private func saveProfileData() {
        guard let userUID = userUID else {
            print("No user UID found")
            return
        }
        
        // Prepare profile data to save into the profile child
        let profileData: [String: Any] = [
            "employer": employerTextField.text ?? "",
            "location": locationTextField.text ?? "",
            "profileImage": "" // Placeholder; handle image upload to Firebase Storage separately
        ]
        
        // Save profile data to Firebase under the profile child
        databaseRef.child("users").child(userUID).child("profile").setValue(profileData) { error, _ in
            if let error = error {
                print("Failed to save profile data: \(error.localizedDescription)")
            } else {
                print("Profile data saved successfully!")
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        saveButton.isHidden = true // Hide save button initially
        toggleEditingMode(isEditing: false)
        setupProfileImageTap()
    }
    
    private func toggleEditingMode(isEditing: Bool) {
        isInEditMode = isEditing
        
        // Toggle text field interaction
        employerTextField.isUserInteractionEnabled = isEditing
        locationTextField.isUserInteractionEnabled = isEditing
        
        // Toggle text view interaction (if required)
        jobExperienceTextView.isEditable = isEditing
        educationTextView.isEditable = isEditing
        skillsTextView.isEditable = isEditing
        
        // Show/hide buttons
        saveButton.isHidden = !isEditing
        editButton.isHidden = isEditing
    }
    
    private func setupProfileImageTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc private func profileImageTapped() {
        if isInEditMode {
            // Open image picker (implement separately)
        }
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: UIButton) {
        toggleEditingMode(isEditing: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        toggleEditingMode(isEditing: false)
        saveProfileData() // Save profile data into a new child collection
    }
}
