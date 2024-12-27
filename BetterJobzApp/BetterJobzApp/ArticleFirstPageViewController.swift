//
//  ArticleFirstPageViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 26/12/2024.
//

//
//  ArticleFirstPageViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 26/12/2024.
//

import UIKit
import FirebaseAuth

class ArticleFirstPageViewController: BaseArticleViewController {

    @IBOutlet weak var firstLikeButton: UIButton!
    @IBOutlet weak var firstSaveButton: UIButton!
    
    @IBOutlet weak var secondLikeButton: UIButton!
    @IBOutlet weak var secondSaveButton: UIButton!

    var isFirstButtonLiked = false
    var isFirstButtonSaved = false
    
    var isSecondButtonLiked = false
    var isSecondButtonSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign user ID after login
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        self.userID = userID

        // Fetch and update button states
        fetchButtonStates(likeKey: "likeButtonState", saveKey: "saveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isFirstButtonLiked = isLiked
            self.isFirstButtonSaved = isSaved
            self.updateFirstButtonImages()
        }
        
        // Fetch and update states for the second set of buttons
        fetchButtonStates(likeKey: "secondLikeButtonState", saveKey: "secondSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateSecondButtonImages()
        }

        // Add a real-time listener
        addRealTimeListener(likeKey: "likeButtonState", saveKey: "saveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isFirstButtonLiked = isLiked
            self.isFirstButtonSaved = isSaved
            self.updateFirstButtonImages()
        }
        
        //Second listener
        addRealTimeListener(likeKey: "secondLikeButtonState", saveKey: "secondSaveButtonState") { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateSecondButtonImages()
        }
    }

    @IBAction func firstLikeButtonTapped(_ sender: Any) {
        isFirstButtonLiked.toggle()
        saveButtonStates(
            likeKey: "likeButtonState",
            saveKey: "saveButtonState",
            isLiked: isFirstButtonLiked,
            isSaved: isFirstButtonSaved
        )
    }

    @IBAction func firstSaveButtonTapped(_ sender: Any) {
        isFirstButtonSaved.toggle()
        saveButtonStates(
            likeKey: "likeButtonState",
            saveKey: "saveButtonState",
            isLiked: isFirstButtonLiked,
            isSaved: isFirstButtonSaved
        )
    }
    
    // Second Like Button Tapped
    @IBAction func secondLikeButtonTapped(_ sender: Any) {
        isSecondButtonLiked.toggle()
        saveButtonStates(
            likeKey: "secondLikeButtonState",
            saveKey: "secondSaveButtonState",
            isLiked: isSecondButtonLiked,
            isSaved: isSecondButtonSaved
        )
    }

    // Second Save Button Tapped
    @IBAction func secondSaveButtonTapped(_ sender: Any) {
        isSecondButtonSaved.toggle()
        saveButtonStates(
            likeKey: "secondLikeButtonState",
            saveKey: "secondSaveButtonState",
            isLiked: isSecondButtonLiked,
            isSaved: isSecondButtonSaved
        )
    }

    // Update images for the first set of buttons
    private func updateFirstButtonImages() {
        firstLikeButton.setImage(UIImage(systemName: isFirstButtonLiked ? "heart.fill" : "heart"), for: .normal)
        firstSaveButton.setImage(UIImage(systemName: isFirstButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
    
    // Update images for the second set of buttons
    private func updateSecondButtonImages() {
        secondLikeButton.setImage(UIImage(systemName: isSecondButtonLiked ? "heart.fill" : "heart"), for: .normal)
        secondSaveButton.setImage(UIImage(systemName: isSecondButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }

    // Second Article Button Action
    @IBAction func secondArticleTapped(_ sender: Any) {
        // Define the website URL
        let websiteURL = URL(string: "https://drexel.edu/scdc/professional-resources/application-materials/resumes/experience-description")!

        // Open the URL
        if UIApplication.shared.canOpenURL(websiteURL) {
            UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
}
