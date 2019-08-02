//
//  PhotoSelectorViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UIViewController {

    //Properties
    weak var delegate: getPhotoDataDelegate?
    weak var selectDelegate: PhotoSelectorViewControllerDelegate?
    var photos: [Photo] = []
    
    //Outlets
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageCountLabel: UILabel!
    
    //Lifecycle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //Actions
    //Present Image Selector View
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet(on: self.view)
    }
}

//Imge Picker Delegate Functions
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Image Picker Data
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let newPhoto = Photo(photo: photo)
            photos.append(newPhoto)
            selectedImageView.image = photos.first?.photo
            selectDelegate?.photoSelectorViewControllerSelected(image: photo)
            cameraButton.setTitle("", for: .normal)
            if photos.count == 0 {
                imageCountLabel.isHidden = true
            } else if photos.count == 1 {
                imageCountLabel.text = "+"
            } else if photos.count >= 2 {
                imageCountLabel.text = "+ \(photos.count - 1)"
            }
        }
    }
    
    //Dismiss Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Alert Action to pick Camera or Library Photo
    func presentImagePickerActionSheet(on view: UIView) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        //Action Sheets
        let initialActionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        let secondaryActionSheet = UIAlertController(title: "What Would You Like To Do?", message: nil, preferredStyle: .actionSheet)
        
        //Action Options
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            initialActionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            initialActionSheet.addAction(UIAlertAction(title: "Take a Photo", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            initialActionSheet.popoverPresentationController?.sourceView = view
            initialActionSheet.popoverPresentationController?.sourceRect = view.bounds
            initialActionSheet.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        initialActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        secondaryActionSheet.addAction(UIAlertAction(title: "Add Photo", style: .default, handler: { (_) in
            self.present(initialActionSheet, animated: true)
        }))
        //Go to PhotoViewController with Photo CollectionView
        secondaryActionSheet.addAction(UIAlertAction(title: "View Photos", style: .default, handler: { (_) in
            let photosViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "photoCollection")
            self.navigationController?.pushViewController(photosViewController, animated: true)
        }))
        secondaryActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if photos.isEmpty {
            present(initialActionSheet, animated: true)
        } else {
            present(secondaryActionSheet, animated: true)
        }
    }
}

protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}

protocol getPhotoDataDelegate: class {
    func getPhotos(set: Bool)
}
