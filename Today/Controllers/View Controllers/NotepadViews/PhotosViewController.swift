//
//  PhotosViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    //Properties
    var photos: [Photo]?
    
    //Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

//Collection View Data Source
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else { return 0 }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photo = photos?[indexPath.row]
        cell.photo = photo
        cell.updateViews()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImagePopUp" {
            
        }
    }
}
