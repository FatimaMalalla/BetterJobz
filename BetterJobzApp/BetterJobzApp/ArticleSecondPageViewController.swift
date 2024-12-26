//
//  ArticleSecondPageViewController.swift
//  BetterJobzApp
//
//  Created by Guest User on 26/12/2024.
//

import UIKit
import FirebaseAuth

class ArticleSecondPageViewController: BaseArticleViewController {

    @IBOutlet weak var secondLikeButton: UIButton!
    @IBOutlet weak var secondSaveButton: UIButton!

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
        fetchButtonStates { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateButtonImages()
        }

        // Add a real-time listener
        buttonStateChangeHandler = { [weak self] isLiked, isSaved in
            guard let self = self else { return }
            self.isSecondButtonLiked = isLiked
            self.isSecondButtonSaved = isSaved
            self.updateButtonImages()
        }
        addRealTimeListener()
    }

    @IBAction func secondLikeButtonTapped(_ sender: Any) {
        isSecondButtonLiked.toggle()
        saveButtonStates(isLiked: isSecondButtonLiked, isSaved: isSecondButtonSaved)
    }

    @IBAction func secondSaveButtonTapped(_ sender: Any) {
        isSecondButtonSaved.toggle()
        saveButtonStates(isLiked: isSecondButtonLiked, isSaved: isSecondButtonSaved)
    }

    private func updateButtonImages() {
        secondLikeButton.setImage(UIImage(systemName: isSecondButtonLiked ? "heart.fill" : "heart"), for: .normal)
        secondSaveButton.setImage(UIImage(systemName: isSecondButtonSaved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
}
