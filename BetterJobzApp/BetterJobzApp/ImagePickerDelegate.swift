import UIKit

protocol ImagePickerDelegate: AnyObject {
    func didSelectProfileImage(_ image: UIImage?)
}

class ImagePickerViewController: UIViewController {
    weak var delegate: ImagePickerDelegate?

    // Outlets

    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var pfp6: UIImageView!
    
    @IBOutlet weak var pfp5: UIImageView!
    
    @IBOutlet weak var pfp4: UIImageView!
    
    @IBOutlet weak var pfp3: UIImageView!
    
    @IBOutlet weak var pfp2: UIImageView!
    
    @IBOutlet weak var pfp1: UIImageView!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var selectedImage: UIImage? // Store selected image

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageTaps()
    }

    func setupImageTaps() {
        let imageViews = [pfp1, pfp2, pfp3, pfp4, pfp5, pfp6]
        for imageView in imageViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView?.addGestureRecognizer(tapGesture)
            imageView?.isUserInteractionEnabled = true
        }
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            selectedImage = tappedImageView.image
            previewImageView.image = selectedImage // Show preview of selected image
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        delegate?.didSelectProfileImage(selectedImage)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil) // Discard changes
    }
}
