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
    weak var selectDelegate: PhotoSelectorViewControllerDelegate?
    
    //Outlets
    @IBOutlet weak var cameraButton: UIButton!
    
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
            selectDelegate?.photoSelectorViewControllerSelected(image: photo)
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
        
        present(initialActionSheet, animated: true)
    }
}

protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}

