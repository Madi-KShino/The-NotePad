//
//  PhotosViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var photos: [Photo] = [] {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    //Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//Collection View Data Source
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.row]
        cell.photo = photo
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImagePopUp" {
            let destination = segue.destination as? PhotoPopupViewController
            guard let cell = sender as? PhotoCollectionViewCell,
                let indexPath = photosCollectionView.indexPath(for: cell)
                else { return }
            let photo = photos[indexPath.row]
            destination?.photo = photo
        }
    }
}

extension PhotosViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        let newImage = Photo(photo: image)
        //save to Notepad in Firebase
        photos.append(newImage)
    }
}
